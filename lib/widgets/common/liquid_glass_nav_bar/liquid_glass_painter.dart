import 'package:flutter/material.dart';

class LiquidGlassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(40));

    // Rim Light (Top Edge - Sharp & Bright)
    final paintRim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect.inflate(-0.5), paintRim);

    // Bottom Ambient Reflection (Soft & Subtle)
    final paintGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Colors.white.withOpacity(0.3), Colors.transparent],
      ).createShader(rect);

    canvas.drawRRect(rrect.inflate(-1), paintGlow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
