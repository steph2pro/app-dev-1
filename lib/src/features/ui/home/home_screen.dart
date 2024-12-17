import 'dart:math';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:crush_app/gen/assets.gen.dart';
import 'package:crush_app/src/core/helpers/utils.dart';
import 'package:crush_app/src/core/theme/dimens.dart';
import 'package:crush_app/src/shared/components/buttons/filter_buttons.dart';
import 'package:crush_app/src/shared/components/gap.dart';
import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Variables pour les points animés
  List<Offset> _points = [];
  List<Color> _colors = [];

  @override
  void initState() {
    super.initState();

    // Initialisation des animations existantes
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Initialisation des points flottants
    _initFloatingPoints();

    // Animation pour faire bouger les points
    _controller.addListener(() {
      setState(() {
        _updateFloatingPoints();
      });
    });
  }

  void _initFloatingPoints() {
    final random = Random();
    _points = List.generate(20, (index) {
      return Offset(random.nextDouble() * 400, random.nextDouble() * 800);
    });

    _colors = [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.purpleAccent,
    ];
  }

  void _updateFloatingPoints() {
    final random = Random();
    _points = _points.map((point) {
      double dx = point.dx + random.nextDouble() * 2 - 1;
      double dy = point.dy + random.nextDouble() * 2 - 1;

      return Offset(
        dx % MediaQuery.of(context).size.width,
        dy % MediaQuery.of(context).size.height,
      );
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _gotoVideoProposal() {
    goTo(context, '/video-call-proposal');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Assets.images.homelayerPng.image(
            width: size.width,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Ajout du flou avec BackdropFilter
          Container(
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),

          // Points flottants animés
          CustomPaint(
            painter: FloatingDotsPainter(_points, _colors),
            child: Container(),
          ),

          // Animation de pulsation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary.withOpacity(0.02),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Contenu principal existant
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap.vertical(height: size.height / 6),
                SvgPicture.asset(Assets.images.camerahome),
                const Gap.vertical(height: Dimens.doubleSpacing),
                Text(
                  "Rencontre des",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSecondary,
                      fontSize: 30),
                ),
                Center(
                    child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(0.19),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0XFFD62E4A),
                        borderRadius: BorderRadius.circular(15)),
                    width: 140,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Crushs",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
                Text(
                  "autour de toi",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSecondary,
                      fontSize: 30),
                ),
                const Gap.vertical(height: Dimens.spacing),
                InkWell(
                  onTap: _gotoVideoProposal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: context.colorScheme.onSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 18, right: 18),
                      child: Column(
                        children: [
                          Text("Appuyez sur l'écran pour commencer",
                              style: TextStyle(
                                color: context.colorScheme.onSecondary,
                              )),
                          Text("à rencontrer des personnes",
                              style: TextStyle(
                                color: context.colorScheme.onSecondary,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap.vertical(height: Dimens.spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.images.minicamera),
                    const SizedBox(width: 15),
                    Text("10 341 personnes en ligne",
                        style: TextStyle(
                          color: context.colorScheme.onSecondary,
                        ))
                  ],
                ),
                Gap.vertical(height: size.height / 7),
                FilterButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FloatingDotsPainter extends CustomPainter {
  final List<Offset> positions;
  final List<Color> colors;

  FloatingDotsPainter(this.positions, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < positions.length; i++) {
      paint.color = colors[i % colors.length];
      canvas.drawCircle(positions[i], 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
