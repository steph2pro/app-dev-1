import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/environment.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/features/ui/video_chat/zim_call_invite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZimVideoCallScreen  extends StatefulWidget {
  final String targetUserID;
  final String targetUserName;
  const ZimVideoCallScreen(
      {super.key, required this.targetUserID, required this.targetUserName});

  @override
  State<ZimVideoCallScreen> createState() => _ZimVideoCallScreenState();
}

class _ZimVideoCallScreenState extends State<ZimVideoCallScreen> {
  UserModel userData = UserModel.empty();

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

// on App's user login
  void onUserLogin(UserModel user) {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.

    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: Environment.appID, // Input your AppID
      appSign: Environment.appSign, // Input your AppSign
      userID: user.username,
      userName: user.username,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var user = await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);

      if (user != null && user.accessToken != null) {
        setState(() {
          userData = user;
        });
        onUserLogin(userData);
      }
    });
  }

  @override
  void dispose() {
    onUserLogout();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        onPressed: () {
          // ZegoUIKitPrebuiltCallInvitationService().init(
          //   appID: Environment.appID, // Input your AppID
          //   appSign: Environment.appSign, // Input your AppSign
          //   userID: userData.username,
          //   userName: userData.username,
          //   plugins: [ZegoUIKitSignalingPlugin()],
          // );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ZimCallInvite(
                        targetUserID: widget.targetUserID,
                        targetUserName: widget.targetUserName,
                      )));
        },
        icon: SvgPicture.asset(Assets.images.iconvideochat),
      ),
    ); // Replace with your UI code
  }
}
