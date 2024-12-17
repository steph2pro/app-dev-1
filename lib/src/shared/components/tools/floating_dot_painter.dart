import 'package:flutter/material.dart';

class FloatingDotsPainter extends CustomPainter {
  final List<Offset> positions;
  final List<Color> colors;

  FloatingDotsPainter(this.positions, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < positions.length; i++) {
      paint.color = colors[i % colors.length];
      canvas.drawCircle(positions[i], 5, paint); // Taille du point
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
