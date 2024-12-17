import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/chat/chat_conversation_model.dart';
import 'package:crush_app/src/datasource/models/chat/participant_model.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/repositories/chat_repository.dart';
import 'package:crush_app/src/features/logic/providers/chat_provider.dart';
import 'package:crush_app/src/features/ui/chat/input_chat_message.dart';
import 'package:crush_app/src/shared/components/chat/render_single_message.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:crush_app/src/shared/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AgoraChatConfig {
  static const String appKey = "711250420#1442881";
  static String userId = "1234";

  static const String agoraToken =
      "007eJxTYFinUFvkI8sR/TrCe34ue/6FF4ds+qvmzmc5dqUjW0nc47oCg7lpmklqWqJZioW5sYmxRbKluaWJhVGqoblRiqVpSnLagTLP9IZARgbRzOssjAysDIxACOKrMJgYGKWkGBsb6CamGpnpGhqmpulaWKYl61qmWVpamCYaJZoYGwIA2P4lyQ==";
}

@RoutePage()
class SingleChatScreen extends StatefulWidget implements AutoRouteWrapper {
  final String chatId;

  const SingleChatScreen({
    // super.key,
    @PathParam('chatId') required this.chatId, // Chat ID passé via la route
  });

  @override
  _SingleChatScreenState createState() => _SingleChatScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  var UNIQUE_HANDLER_ID =
      "UNIQUE_HANDLER_ID_${DateTime.now().millisecondsSinceEpoch}";
  ScrollController scrollController = ScrollController();
  final List<String> _logText = [];
  final ChatRepository _chatRepository = locator<ChatRepository>();
  String conversationAgoraToken = "";
  ChatConversationModel? _currentConversation;
  UserModel user = UserModel.empty();
  Participant _destinator = Participant.empty();
  // final List<ChatMessage> _chatMessages = [];
  void _back() {
    context.router.back();
  }

  @override
  void initState() {
    super.initState();
    // _initSDK();
    // _addChatListener();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
    //   var userData =
    //       await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);
    //   if (userData != null) {}
    //   ChatConversationModel? currentConversation;
    //   setState(() {
    //     user = userData!;
    //     currentConversation = context
    //         .read<ChatProvider>()
    //         .getConversationByChanelName(widget.chatId);
    //     if (currentConversation == null) {
    //     } else {
    //       List<Participant> filteredUsers = _currentConversation!.participants
    //           .where((user) => user.id != userData.id)
    //           .toList();

    //       _destinator = filteredUsers.first;

    //       log('conversation get in single chat _destinator ' +
    //           _destinator!.toJson().toString());
    //     }
    //   });

    //   try {
    //     var response = await _chatRepository.getConversationToken(
    //         currentConversation == null ? widget.chatId : _destinator.id);
    //     response.when(
    //       success: (token) {
    //         if (currentConversation == null) {
    //           context
    //               .read<ChatProvider>()
    //               .fetchConversations(identifier: _destinator.id);
    //         }
    //         conversationAgoraToken = token;
    //         _signIn(token, userData!.username);
    //       },
    //       error: (error) {},
    //     );
    //   } catch (e) {}
    // });
  }

  @override
  void dispose() {
    // ChatClient.getInstance.chatManager.removeMessageEvent(UNIQUE_HANDLER_ID);
    // ChatClient.getInstance.chatManager.removeEventHandler(UNIQUE_HANDLER_ID);
    super.dispose();
  }

  // void _initSDK() async {
  //   ChatOptions options = ChatOptions(
  //     appKey: AgoraChatConfig.appKey,
  //     autoLogin: false,
  //   );
  //   await ChatClient.getInstance.init(options);
  //   await ChatClient.getInstance.startCallback();
  // }

  // void _addChatListener() {
  //   ChatClient.getInstance.chatManager.addMessageEvent(
  //       UNIQUE_HANDLER_ID,
  //       ChatMessageEvent(
  //         onSuccess: (msgId, msg) {
  //           // setState(() {
  //           // });

  //           context.read<ChatProvider>().addToMessage(msg);
  //           scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //           _addLogToConsole("send message succeed");
  //         },
  //         onProgress: (msgId, progress) {
  //           _addLogToConsole("send message succeed");
  //         },
  //         onError: (msgId, msg, error) {
  //           _addLogToConsole(
  //             "send message failed, code: ${error.code}, desc: ${error.description}",
  //           );
  //         },
  //       ));

  //   ChatClient.getInstance.chatManager.addEventHandler(
  //     UNIQUE_HANDLER_ID,
  //     ChatEventHandler(onMessagesReceived: onMessagesReceived),
  //   );
  // }

  // void _signIn(String agoraToken, String userId) async {
  //   try {
  //     print(
  //         "=======================dtat for login userId: ${userId}  token : ${agoraToken} ");
  //     await ChatClient.getInstance.loginWithAgoraToken(
  //       userId,
  //       agoraToken,
  //     );
  //     _getHistoryConversation();
  //     _addLogToConsole("login succeed, userId: ${AgoraChatConfig.userId}");
  //   } on ChatError catch (e) {
  //     if (e.description.contains('already logged')) _getHistoryConversation();
  //     _addLogToConsole("login failed, code: ${e.code}, desc: ${e.description}");
  //   }
  // }

  // void _signOut() async {
  //   try {
  //     await ChatClient.getInstance.logout(true);
  //     _addLogToConsole("sign out succeed");
  //   } on ChatError catch (e) {
  //     _addLogToConsole(
  //         "sign out failed, code: ${e.code}, desc: ${e.description}");
  //   }
  // }

  // void sendMessage(String textMessage) async {
  //   // if (_chatId == null || _messageContent == null) {
  //   //   _addLogToConsole("single chat id or message content is null");
  //   //   return;
  //   // }

  //   var msg = ChatMessage.createTxtSendMessage(
  //     targetId: _destinator.username,
  //     content: textMessage,
  //   );
  //   _addLogToConsole(
  //       "send message to ${_destinator.username} , message : ${textMessage} ");
  //   ChatClient.getInstance.chatManager.sendMessage(msg);
  // }

  // void _addLogToConsole(String log) {
  //   print(" : " + log);
  //   setState(() {
  //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //   });
  // }

  // void _getHistoryConversation() async {
  //   String? cursor = "1";
  //   int pageSize = 20;

  //   try {
  //     ChatCursorResult<ChatMessage> result =
  //         await ChatClient.getInstance.chatManager.fetchHistoryMessages(
  //       conversationId: _destinator.username,
  //       pageSize: pageSize,
  //     );

  //     // var msg = await ChatClient.getInstance.chatManager.loadAllConversations();
  //     // onMessagesReceived(result.data);
  //     // setState(() {
  //     // });
  //     context.read<ChatProvider>().addAllToMessage(result.data);

  //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //     setState(() {
  //       scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //     });
  //     // print("_chatMessages conversation ===  " + result.data.toString());
  //     // var data = await result.data[0].lastReceivedMessage();
  //     // print("conversation id get:============== " + data.toString());
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void onMessagesReceived(List<ChatMessage> messages) {
  //   print(
  //       '_chatMessages  before receive new messages: ===========================');
  //   // setState(() {
  //   // });
  //   // context.read<ChatProvider>().addAllToMessage(messages);
  //   // scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //   // _chatMessages.addAll(messages);
  //   print(
  //       '_chatMessages  after receive new messages: ===========================');
  //   for (var msg in messages) {
  //     switch (msg.body.type) {
  //       case MessageType.TXT:
  //         {
  //           context.read<ChatProvider>().addToMessage(msg);
  //           scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //           setState(() {
  //             scrollController
  //                 .jumpTo(scrollController.position.maxScrollExtent);
  //           });
  //           ChatTextMessageBody body = msg.body as ChatTextMessageBody;
  //           _addLogToConsole(
  //             "receive text message: ${body.content}, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.IMAGE:
  //         {
  //           _addLogToConsole(
  //             "receive image message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.VIDEO:
  //         {
  //           _addLogToConsole(
  //             "receive video message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.LOCATION:
  //         {
  //           _addLogToConsole(
  //             "receive location message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.VOICE:
  //         {
  //           _addLogToConsole(
  //             "receive voice message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.FILE:
  //         {
  //           _addLogToConsole(
  //             "receive image message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.CUSTOM:
  //         {
  //           _addLogToConsole(
  //             "receive custom message, from: ${msg.from}",
  //           );
  //         }
  //         break;
  //       case MessageType.CMD:
  //         {
  //           // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
  //         }
  //         break;
  //       default:
  //         ChatTextMessageBody body = msg.body as ChatTextMessageBody;
  //         _addLogToConsole(
  //           "receive unknow message: ${body.content}, from: ${msg.from}",
  //         );
  //         break;
  //     }
  //   }
  //   setState(() {
  //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    _currentConversation = context.watch<ChatProvider>().currentConversation;
    // List<ChatMessage> chatMessages = context.watch<ChatProvider>().chatMessages;
    final ChatRepository _chatRepository = locator<ChatRepository>();
    return Scaffold(
      // backgroundColor: context.colorScheme.outlineVariant.withOpacity(0.1),
      body: Column(
        children: [
          // Header Section
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
                      InkWell(
                        onTap: _back,
                        child: const Icon(Icons.arrow_back),
                      ),
                      Row(
                        children: [
                          const RenderAvatar(
                            size: 18,
                            isWithStatus: true,
                            isOnline: false,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _destinator!.username ?? "", // Accès au chatId
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                      SvgPicture.asset(Assets.images.iconvideochat),
                    ],
                  ),
                ),
                // Status Section
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.radius),
                    color: context.colorScheme.tertiary.withOpacity(0.1),
                  ),
                  child: const Text(
                    "En ligne il y'a 2h",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          // Chat Section
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: index == 20
                              ? size.height / 10
                              : size.height / 20),
                      child: RenderSingleMessage(
                        isMe: index % 2 == 0,
                        // message: chatMessages[index],
                      ),
                    );
                  },
                ),
                const Gap.vertical(height: Dimens.doubleSpacing),
                // Input Field Fixed at Bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InputChatMessage(
                    onSendMessage: (text) {
                      print(text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
