import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZimCallInvite extends StatefulWidget {
  final String targetUserID;
  final String targetUserName;
  const ZimCallInvite(
      {super.key, required this.targetUserID, required this.targetUserName});

  @override
  State<ZimCallInvite> createState() => _ZimCallInviteState();
}

class _ZimCallInviteState extends State<ZimCallInvite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ZegoSendCallInvitationButton(
          isVideoCall: true,
          // You need to use the resourceID that you created
          // Please continue reading this document.
          resourceID: "crush_call",
          invitees: [
            ZegoUIKitUser(
              id: widget.targetUserID,
              name: widget.targetUserName,
            ),
          ],
        ),
      ),
    );
  }
}
