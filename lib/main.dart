import 'dart:async';

import 'package:crush_app/firebase_options.dart';
import 'package:crush_app/src/core/app_initializer.dart';
import 'package:crush_app/src/core/application.dart';
import 'package:crush_app/src/core/environment.dart';
import 'package:crush_app/src/features/logic/providers/auth_provider.dart';
import 'package:crush_app/src/features/logic/providers/chat_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> createEngine() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get your AppID and AppSign from ZEGOCLOUD Console
  //[My Projects -> AppID] z: https://console.zegocloud.com/project
  await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    Environment.appID,
    ZegoScenario.Default,
    appSign: kIsWeb ? null : Environment.appSign,
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // await messaging.setAutoInitEnabled(true);

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // await messaging.getNotificationSettings();
  createEngine();
  await ZIMKit().init(
    appID: Environment.appID,
    appSign: Environment.appSign,
  );

  final AppInitializer appInitializer = AppInitializer();

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  });
  runZonedGuarded(
    () async {
      await appInitializer.preAppRun();

      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ChatProvider()),
        ],
        child: Application(
          navigatorKey: navigatorKey,
        ),
      ));

      appInitializer.postAppRun();
    },
    (error, stack) {
      // Gérer les erreurs globales ici si nécessaire
      print('Error: $error\nStackTrace: $stack');
    },
  );
}
