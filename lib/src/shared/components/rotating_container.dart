import 'package:crush_app/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class RotatingContainer extends StatefulWidget {
  @override
  _RotatingContainerState createState() => _RotatingContainerState();
}

class _RotatingContainerState extends State<RotatingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Répète l'animation

    _animation = Tween<double>(begin: 1, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            // angle: _animation.value,
            scale: _animation.value,
            child: Container(
              width: 70,
              height: 25,
              color: Colors.red,
              child: Center(
                  child: Text(
                "Crushs",
                style: TextStyle(
                    color: context.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold),
              )),
            ),
          );
        },
      ),
    );
  }
}
