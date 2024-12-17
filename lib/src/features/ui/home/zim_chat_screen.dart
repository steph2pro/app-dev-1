import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/user/user_chat.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/features/logic/providers/chat_provider.dart';
import 'package:crush_app/src/features/ui/video_chat/zim_video_call_screen.dart';
import 'package:crush_app/src/shared/components/chat/render_list_message_element.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

// home_page.dart
@RoutePage()
class ZimChatScreen extends StatefulWidget implements AutoRouteWrapper {
  ZimChatScreen({Key? key}) : super(key: key);

  @override
  State<ZimChatScreen> createState() => _ZimChatScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _ZimChatScreenState extends State<ZimChatScreen> {
  UserModel user = UserModel.empty();

  Future<void> _createConversation(BuildContext context, String userId) async {
    if (userId != null && userId.isNotEmpty) {
      try {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ZIMKitMessageListPage(
              conversationID: userId,
              conversationType: ZIMConversationType.peer,
            );
          },
        ));
      } catch (e) {
        print('Erreur lors de la création de la conversation : $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ChatProvider>().getUsersList();
      var userData =
          await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);
      if (userData != null) {
        await ZIMKit()
            .connectUser(id: userData.username, name: userData.username);
      }
      setState(() {
        user = userData!;
      });
      // context.read<ChatProvider>().fetchConversations();
      // context.read<ChatProvider>().getUsersList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<UserChat> usersChat = context.watch<ChatProvider>().usersChat;
    return PopScope(
      // onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Conversations'),
        //   actions: const [Text('test')],
        // ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimens.radius),
                  bottomRight: Radius.circular(Dimens.radius),
                ),
              ),
              child: Column(
                children: [
                  const Gap.vertical(height: Dimens.doubleSpacing),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Messages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SvgPicture.asset(Assets.images.notificationicon),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Gap.horizontal(width: Dimens.spacing),
                      Text(
                        "Nouvelle demandes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Gap.horizontal(width: Dimens.spacing),
                      Text(
                        "Nouvelles demandes",
                        style: TextStyle(
                          fontSize: 10,
                          color: context.colorScheme.tertiary.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: size.height / 8,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        usersChat.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => _createConversation(
                                context, usersChat[index].username),
                            child: RenderAvatar(
                              size: 20,
                              isWithStatus: true,
                              isOnline: index % 2 == 0,
                              name: '@' + usersChat[index].username,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: context.colorScheme.onPrimary,
                child: ZIMKitConversationListView(
                  theme: ThemeData.light(),
                  itemBuilder: (context, conversation, defaultWidget) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: size.height / 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ZIMKitMessageListPage(
                                messageInputMaxLines: 3,
                                messageInputMinLines: 3,
                                conversationID: conversation.id,
                                conversationType: conversation.type,
                                appBarActions: [
                                  ZimVideoCallScreen(
                                    targetUserID: conversation.id,
                                    targetUserName: conversation.id,
                                  ),
                                ],
                              );
                            },
                          ));
                        },
                        child: RenderListMessageElement(
                          conversation: conversation,
                        ),
                      ),
                    );
                  },
                  // onPressed: (context, conversation, defaultAction) {
                  //   Navigator.push(context, MaterialPageRoute(
                  //     builder: (context) {
                  //       return ZIMKitMessageListPage(
                  //         conversationID: conversation.id,
                  //         conversationType: conversation.type,
                  //         appBarActions: [
                  //           ZimVideoCallScreen(
                  //             targetUserID: conversation.id,
                  //             targetUserName: conversation.id,
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ));
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
