import 'package:zego_zimkit/zego_zimkit.dart';

class ZIMService {
  ZIMService._internal();
  factory ZIMService() => instance;
  static final ZIMService instance = ZIMService._internal();
  Future<void> init({required int appID, String appSign = ''}) async {
    // initEventHandle();
    ZIM.create(
      ZIMAppConfig()
        ..appID = appID
        ..appSign = appSign,
    );
  }
  // ...

  Future<void> connectUser(String userID, String userName) async {
    ZIMUserInfo userInfo = ZIMUserInfo();
    userInfo.userID = userID;
    userInfo.userName = userName;
    // zimUserInfo = userInfo;
    ZIMKit().connectUser(id: userID, name: userName);
  }
}
