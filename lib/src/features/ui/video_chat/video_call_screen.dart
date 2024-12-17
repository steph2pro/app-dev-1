import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/forms/input.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/components/tools/render_small_message.dart';
import 'package:crush_app/src/shared/components/video_chat/emetter_call.dart';
import 'package:crush_app/src/shared/components/video_chat/receiver_call.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

// @RoutePage()
class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen(
      {super.key,
      required this.localUserID,
      required this.localUserName,
      required this.roomID});
  final String localUserID;
  final String localUserName;
  final String roomID;
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   return this;
  // }
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  Widget? localView;
  int? localViewID;
  Widget? remoteView;
  int? remoteViewID;
  late String defaultAvatar;
  late Size size;

  void startListenEvent() {
    // Callback for updates on the status of other users in the room.
    // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
    ZegoExpressEngine.onRoomUserUpdate =
        (roomID, updateType, List<ZegoUser> userList) {
      debugPrint(
          'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
    };
    // Callback for updates on the status of the streams in the room.
    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
      debugPrint(
          'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
      if (updateType == ZegoUpdateType.Add) {
        for (final stream in streamList) {
          startPlayStream(stream.streamID);
        }
      } else {
        for (final stream in streamList) {
          stopPlayStream(stream.streamID);
        }
      }
    };
    // Callback for updates on the current user's room connection status.
    ZegoExpressEngine.onRoomStateUpdate =
        (roomID, state, errorCode, extendedData) {
      debugPrint(
          'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };

    // Callback for updates on the current user's stream publishing changes.
    ZegoExpressEngine.onPublisherStateUpdate =
        (streamID, state, errorCode, extendedData) {
      debugPrint(
          'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
    };
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
  }

  Future<ZegoRoomLoginResult> loginRoom() async {
    print("infos login : ${widget.localUserID} name ${widget.localUserName} ");
    // The value of `userID` is generated locally and must be globally unique.
    final user = ZegoUser(widget.localUserID, widget.localUserName);

    // The value of `roomID` is generated locally and must be globally unique.
    final roomID = widget.roomID;

    // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true;

    if (kIsWeb) {
      // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
      // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
      // roomConfig.token =
      //     ZegoTokenUtils.generateToken(appID, serverSecret, widget.localUserID);
    }
    // log in to a room
    // Users must log in to the same room to call each other.
    return ZegoExpressEngine.instance
        .loginRoom(roomID, user, config: roomConfig)
        .then((ZegoRoomLoginResult loginRoomResult) {
      debugPrint(
          'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
      if (loginRoomResult.errorCode == 0) {
        startPreview();
        startPublish();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
      }
      return loginRoomResult;
    });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(widget.roomID);
  }

  Future<void> startPreview() async {
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      localViewID = viewID;
      ZegoCanvas previewCanvas =
          ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
    }).then((canvasViewWidget) {
      setState(() => localView = canvasViewWidget);
    });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
      setState(() {
        localViewID = null;
        localView = null;
      });
    }
  }

  Future<void> startPublish() async {
    // After calling the `loginRoom` method, call this method to publish streams.
    // The StreamID must be unique in the room.
    String streamID = '${widget.roomID}_${widget.localUserID}_call';
    return ZegoExpressEngine.instance.startPublishingStream(streamID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<void> startPlayStream(String streamID) async {
    // Start to play streams. Set the view for rendering the remote streams.
    await ZegoExpressEngine.instance.createCanvasView((viewID) {
      remoteViewID = viewID;
      ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
      ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
    }).then((canvasViewWidget) {
      setState(() => remoteView = canvasViewWidget);
    });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      setState(() {
        remoteViewID = null;
        remoteView = null;
      });
    }
  }

  Future<void> requestPermissionsIfNeeded() async {
    // Vérifiez l'état actuel des permissions
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;

    // Créez une liste de permissions à demander uniquement si elles ne sont pas déjà accordées
    List<Permission> permissionsToRequest = [];

    if (!cameraStatus.isGranted) {
      permissionsToRequest.add(Permission.camera);
    }
    if (!microphoneStatus.isGranted) {
      permissionsToRequest.add(Permission.microphone);
    }

    // Si la liste n'est pas vide, alors on demande seulement ces permissions
    if (permissionsToRequest.isNotEmpty) {
      Map<Permission, PermissionStatus> statuses =
          await permissionsToRequest.request();

      // Gérer les cas de refus si nécessaire
      if (statuses[Permission.camera]?.isDenied ?? false) {
        print('L\'utilisateur a refusé la caméra.');
      }
      if (statuses[Permission.microphone]?.isDenied ?? false) {
        print('L\'utilisateur a refusé le microphone.');
      }
    } else {
      // Toutes les permissions nécessaires sont déjà accordées
      print('Toutes les permissions sont déjà accordées');
    }
  }

  @override
  void initState() {
    // requestPermissionsIfNeeded();
    startListenEvent();
    loginRoom();
    super.initState();
    defaultAvatar =
        'https://st.depositphotos.com/2931363/3703/i/450/depositphotos_37034497-stock-photo-young-black-man-smiling-at.jpg';
  }

  @override
  void dispose() {
    stopListenEvent();

    logoutRoom();
    super.dispose();
  }

  void _back() {
    Navigator.pop(context);
    // context.router.back();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          const Gap.vertical(height: Dimens.doubleSpacing),
          remoteView ?? ReceiverCall(),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: EmetterCall(
              emetter: localView,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: size.height / 4,
              width: size.width / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Gap.vertical(height: Dimens.minSpacing),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(defaultAvatar),
                  ),
                  Container(
                    height: 67,
                    width: 80,
                    decoration: BoxDecoration(
                      color: context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimens.fullRadius),
                        bottomLeft: Radius.circular(Dimens.fullRadius),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: SvgPicture.asset(Assets.images.exclamationicon),
                    ),
                  ),
                  Container(
                    height: 67,
                    width: 80,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimens.fullRadius),
                        bottomLeft: Radius.circular(Dimens.fullRadius),
                      ),
                    ),
                    child: InkWell(
                      onTap: _back,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.images.iconarrow,
                            colorFilter: ColorFilter.mode(
                                context.colorScheme.onPrimary, BlendMode.srcIn),
                          ),
                          Text(
                            "Suivant",
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height / 3,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  RenderSmallMessage(
                                    message: "comment tu vas",
                                    avatar: defaultAvatar,
                                  ),
                                  RenderSmallMessage(
                                    message: "ok",
                                    avatar: defaultAvatar,
                                  ),
                                  RenderSmallMessage(
                                    message: "cc cher ami comment tu vas",
                                    avatar: defaultAvatar,
                                  ),
                                  RenderSmallMessage(
                                    message: "cc cher ami comment tu vas",
                                    avatar: defaultAvatar,
                                  ),
                                  RenderSmallMessage(
                                    message: "cc cher ami comment",
                                    avatar: defaultAvatar,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 65,
                          child: Input(
                            hintStyle:
                                TextStyle(color: context.colorScheme.onPrimary),
                            fillColor:
                                context.colorScheme.outline.withOpacity(0.6),
                            radius: Dimens.fullRadius,
                            filled: true,
                            controller: null,
                            enabled: true,
                            expands: true,
                            isPassword: false,
                            isBorderless: false,
                            readOnly: false,
                            hintText: 'Envoyer un message',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(Assets.images.iconfriend),
                          Text(
                            "Devenir",
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                          Text("Ami",
                              style: TextStyle(
                                  color: context.colorScheme.onPrimary))
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(Assets.images.icongift),
                          Text(
                            "Cadeau",
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(Assets.images.iconlike),
                          Text(
                            "Like",
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
