import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/datasource/models/user/user_model.dart';
import 'package:crush_app/src/datasource/storage/local_storage.dart';
import 'package:crush_app/src/features/ui/video_chat/zim_video_call_screen.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VideoChatProposalScreen extends StatefulWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  _VideoChatProposalScreenState createState() =>
      _VideoChatProposalScreenState();
}

class _VideoChatProposalScreenState extends State<VideoChatProposalScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late UserModel user = UserModel.empty();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var userData =
          await LocalStorage().getObject<UserModel>('user', UserModel.fromJson);

      print("user Data ================== " + userData.toString());
      if (userData != null && userData.accessToken != null) {
        print("user infos: ============================= " +
            userData!.userChatId +
            "  username " +
            userData.username);
        user = userData;
      }
    });
    // Initialisation de l'AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Répéter l'animation avec un retour inverse

    _scaleAnimation = Tween<double>(begin: 0.0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _back() {
    Navigator.pop(context);
  }

  void _gotoChatVideo() {
    // context.router.push(const VideoCallRoute());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ZimVideoCallScreen(
          targetUserID: "lele",
          targetUserName: 'lele',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.03),
        child: Stack(
          children: [
            Assets.images.homelayerPng.image(
              width: size.width,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Ajout du flou avec le BackdropFilter
            Container(
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.09),
                  ),
                ),
              ),
            ),
            // Ajout de l'animation de pulsation dans un widget Positioned
            Positioned(
              top:
                  0, // Remplacer par top, left, right et bottom à 0 pour centrer
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child, // Afficher un cercle pulsé
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary
                        .withOpacity(0.02), // Couleur avec transparence
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // Le contenu principal de l'écran
            InkWell(
              onTap: _gotoChatVideo,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height / 20, right: size.width / 20),
                          child: InkWell(
                            onTap: _back,
                            child: Icon(
                              size: 35,
                              Icons.close,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://st.depositphotos.com/2931363/3703/i/450/depositphotos_37034497-stock-photo-young-black-man-smiling-at.jpg'),
                        ),
                        Text("Rencontrez Tianna,",
                            style: TextStyle(
                                color: context.colorScheme.onPrimary,
                                fontSize: 18)),
                        Text(
                          "elle a 24 ans à Douala,",
                          style: TextStyle(
                              color: context.colorScheme.onPrimary,
                              fontSize: 18),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("👑😁✨✨"),
                        Text("Fais un beau sourire,et les gens vont ",
                            style: TextStyle(
                                color: context.colorScheme.onPrimary,
                                fontSize: 14)),
                        Text("accrocher à toi",
                            style: TextStyle(
                                color: context.colorScheme.onPrimary,
                                fontSize: 14))
                      ],
                    ),
                    const Gap.vertical(height: Dimens.spacing),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
