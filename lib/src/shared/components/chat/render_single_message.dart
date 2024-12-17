import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RenderSingleMessage extends StatelessWidget {
  final bool isMe;
  // final ChatMessage? message;
  const RenderSingleMessage({
    super.key,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // onMessageFormat(ChatMessage msg) {
    //   switch (msg.body.type) {
    //     case MessageType.TXT:
    //       {
    //         ChatTextMessageBody body = msg.body as ChatTextMessageBody;
    //         print(
    //           "receive text message: ${body.content}, from: ${msg.from}",
    //         );
    //         return body.content;
    //       }

    //     case MessageType.IMAGE:
    //       {
    //         print(
    //           "receive image message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.VIDEO:
    //       {
    //         print(
    //           "receive video message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.LOCATION:
    //       {
    //         print(
    //           "receive location message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.VOICE:
    //       {
    //         print(
    //           "receive voice message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.FILE:
    //       {
    //         print(
    //           "receive image message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.CUSTOM:
    //       {
    //         print(
    //           "receive custom message, from: ${msg.from}",
    //         );
    //       }
    //       break;
    //     case MessageType.CMD:
    //       {
    //         // Receiving command messages does not trigger the `onMessagesReceived` event, but triggers the `onCmdMessagesReceived` event instead.
    //       }
    //       break;
    //     default:
    //       ChatTextMessageBody body = msg.body as ChatTextMessageBody;
    //       print(
    //         "receive unknow message: ${body.content}, from: ${msg.from}",
    //       );
    //       break;
    //   }
    // }

    return isMe
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(Dimens.radius)),
                  constraints: BoxConstraints(maxWidth: size.width / 1.3),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "Je m’ennuie chez moi qui m’invite dans un resto chic ? c’est toi qui paie hein mon chaud ❤️🥰🍑🍑 ...",
                            style: TextStyle(
                                color: context.colorScheme.onPrimary,
                                fontSize: 14)),
                        Text("11:02",
                            style: TextStyle(
                                color: context.colorScheme.onPrimary,
                                fontSize: 8))
                      ],
                    ),
                  )),
              Gap.horizontal(width: 3),
              RenderAvatar(
                size: 10,
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RenderAvatar(
                size: 10,
              ),
              Gap.horizontal(width: 3),
              Container(
                  decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(Dimens.radius)),
                  constraints: BoxConstraints(maxWidth: size.width / 1.3),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "Je m’ennuie chez moi qui m’invite dans un resto chic ? c’est toi qui paie hein mon chaud ❤️🥰🍑🍑 ...",
                            style: TextStyle(
                                color: context.colorScheme.tertiary,
                                fontSize: 14)),
                        Text("11:03",
                            style: TextStyle(
                                color: context.colorScheme.tertiary,
                                fontSize: 8))
                      ],
                    ),
                  )),
            ],
          );
  }
}
