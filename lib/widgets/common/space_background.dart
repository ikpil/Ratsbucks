import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpaceBackground extends StatefulWidget {
  const SpaceBackground({super.key});

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _AuroraGradientPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _AuroraGradientPainter extends CustomPainter {
  final double animationValue;

  _AuroraGradientPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Create multiple moving gradient centers based on animation
    final double t = animationValue * 2 * math.pi;

    // Orb 1: Blue/Purple
    final Offset center1 = Offset(
      size.width * (0.5 + 0.3 * math.sin(t)),
      size.height * (0.3 + 0.2 * math.cos(t * 0.7)),
    );

    // Orb 2: Orange/Pink
    final Offset center2 = Offset(
      size.width * (0.5 + 0.4 * math.cos(t * 0.8)),
      size.height * (0.7 + 0.2 * math.sin(t * 0.6)),
    );

    // Orb 3: Cyan/Green
    final Offset center3 = Offset(
      size.width * (0.5 + 0.3 * math.sin(t * 1.2 + math.pi)),
      size.height * (0.5 + 0.3 * math.cos(t * 0.9)),
    );

    // We blend these gradients by drawing them with different blend modes
    // Base dark background
    canvas.drawRect(rect, Paint()..color = const Color(0xFF000000));

    // Paint 1
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF4A00E0).withOpacity(0.6), // Purple
          Colors.transparent,
        ],
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: center1, radius: size.width * 0.8))
      ..blendMode = BlendMode.screen;
    canvas.drawRect(rect, paint1);

    // Paint 2
    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF8E2DE2).withOpacity(0.5), // Pink/Violet
          Colors.transparent,
        ],
        radius: 0.7,
      ).createShader(Rect.fromCircle(center: center2, radius: size.width * 0.7))
      ..blendMode = BlendMode.screen;
    canvas.drawRect(rect, paint2);

    // Paint 3
    final paint3 = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF00C6FF).withOpacity(0.5), // Cyan
          Colors.transparent,
        ],
        radius: 0.9,
      ).createShader(Rect.fromCircle(center: center3, radius: size.width * 0.9))
      ..blendMode = BlendMode.screen;
    canvas.drawRect(rect, paint3);
  }

  @override
  bool shouldRepaint(covariant _AuroraGradientPainter oldDelegate) {
    return true;
  }
}
