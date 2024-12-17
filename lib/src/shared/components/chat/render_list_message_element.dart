import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/chat/chat_conversation_model.dart';
import 'package:crush_app/src/datasource/models/chat/participant_model.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_avatar.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class RenderListMessageElement extends StatefulWidget {
  final ChatConversationModel? chatConv;
  final ZIMKitConversation conversation;
  const RenderListMessageElement(
      {super.key, this.chatConv, required this.conversation});

  @override
  _RenderListMessageElementState createState() =>
      _RenderListMessageElementState();
}

class _RenderListMessageElementState extends State<RenderListMessageElement> {
  Participant _destinator = Participant.empty();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userData =
          await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);

      // List<Participant> filteredUsers = widget.chatConv.participants
      //     .where((p) => p.id != userData!.id)
      //     .toList();

      // _destinator = filteredUsers.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RenderAvatar(
          size: 20,
          isWithStatus: true,
          avatarUrl: widget.conversation.avatarUrl,
        ),
        Gap.horizontal(width: Dimens.spacing - 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '@' + widget.conversation.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Column(
                    children: [
                      Text(
                          "${formatTimestamp(widget.conversation.lastMessage?.zim?.timestamp ?? 0) ?? ''}",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 8)),
                      widget.conversation.unreadMessageCount > 0
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 10,
                                minHeight: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.conversation.unreadMessageCount > 9
                                      ? '9+'
                                      : widget.conversation.unreadMessageCount
                                          .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                widget.conversation.lastMessage?.type == ZIMMessageType.text
                    ? "${widget.conversation.lastMessage?.textContent?.text}"
                    : "[${widget.conversation.lastMessage?.type.name}]",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ),
      ],
    );
  }
}
