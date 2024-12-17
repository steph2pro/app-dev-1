import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/user/user_chat.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/features/logic/providers/chat_provider.dart';
import 'package:crush_app/src/shared/components/forms/input.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

@RoutePage()
class ChatScreen extends StatefulWidget implements AutoRouteWrapper {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
    //  BlocProvider(
    //   create: (_) => ChatCubit(chatRepository: ChatRepository()),
    //   child: this,
    // );
  }
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> _onRefesh() async {}
  UserModel user = UserModel.empty();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userData =
          await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);
      if (userData != null) {
        await ZIMKit().connectUser(id: userData.id, name: userData.username);
      }
      setState(() {
        user = userData!;
      });
      context.read<ChatProvider>().fetchConversations();
      context.read<ChatProvider>().getUsersList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<UserChat> usersChat = context.watch<ChatProvider>().usersChat;
    void _gotoSingleChat(String chatId) {
      print("!======================================: " + chatId);
      Navigator.of(context).pushNamed(
        '/single-chat',
        arguments: chatId, // Le chatId que vous souhaitez passer
      );
    }

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: context.colorScheme.outlineVariant.withOpacity(0.1),
      body: RefreshIndicator(
        onRefresh: _onRefesh,
        child: Column(
          children: [
            // Header section
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
                            onTap: () => _gotoSingleChat(usersChat[index].id),
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

            const Gap.vertical(height: Dimens.spacing),
            // Main content section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimens.radius),
                    topRight: Radius.circular(Dimens.radius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: 47,
                        child: Input(
                          hintStyle: TextStyle(
                            color:
                                context.colorScheme.tertiary.withOpacity(0.3),
                          ),
                          fillColor: context.colorScheme.outlineVariant
                              .withOpacity(0.1),
                          radius: Dimens.radius,
                          filled: true,
                          controller: null,
                          enabled: true,
                          expands: true,
                          isPassword: false,
                          isBorderless: false,
                          readOnly: false,
                          hintText: 'Rechercher un message',
                        ),
                      ),

                      // List of messages
                      Expanded(
                        child: Consumer<ChatProvider>(
                          builder: (context, chatProvider, child) {
                            if (chatProvider.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (chatProvider.errorMessage != null) {
                              return Center(
                                  child: Text(
                                      "Erreur: ${chatProvider.errorMessage}"));
                            }

                            final conversations = chatProvider.conversations;

                            if (conversations.isEmpty) {
                              return const Center(
                                  child: Text("Aucune conversation trouvée"));
                            }

                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                // final conversation = conversations[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              25),
                                  child: InkWell(
                                    onTap: () => _gotoSingleChat('1'),
                                    child: Text(
                                        "data"), //RenderListMessageElement(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      // Expanded(
                      //   child: ListView(
                      //     children: List.generate(
                      //       100,
                      //       (index) => Padding(
                      //         padding:
                      //             EdgeInsets.only(bottom: size.height / 25),
                      //         child: InkWell(
                      //             onTap: _gotoSingleChat,
                      //             child: RenderListMessageElement()),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
