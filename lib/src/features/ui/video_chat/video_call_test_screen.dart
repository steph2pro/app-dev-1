import 'dart:math';

import 'package:crush_app/src/shared/utils/zego_constaint.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

final userId=Random().nextInt(9999);

class VideoCallTestScreen extends StatefulWidget {
  final String callId;
  const VideoCallTestScreen({super.key,required this.callId});

  @override
  State<VideoCallTestScreen> createState() => _VideoCallTestScreenState();
}

class _VideoCallTestScreenState extends State<VideoCallTestScreen> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: ZegoConstaint.appId, 
      appSign: ZegoConstaint.appSign,
      userID: userId.toString(), 
      userName: 'userName $userId',
      callID: widget.callId,  
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
    );
  }
}