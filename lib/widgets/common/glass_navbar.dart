import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Map<String, dynamic>> items;
  final bool isVisible;

  const GlassNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
    this.isVisible = true,
  });

  @override
  State<GlassNavBar> createState() => _GlassNavBarState();
}

class _GlassNavBarState extends State<GlassNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elasticAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _elasticAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didUpdateWidget(GlassNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // iOS 26 Liquid Glass Constants
    const double barHeight = 70.0;
    const double floatingBottomMargin = 34.0;
    const double blurSigma = 40.0;

    return AnimatedSlide(
      offset: widget.isVisible ? Offset.zero : const Offset(0, 1.5),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: floatingBottomMargin,
          left: 20,
          right: 20,
        ),
        child: AnimatedBuilder(
          animation: _elasticAnimation,
          builder: (context, child) {
            // Micro-interaction: slight stretch on tap
            final stretch = 1.0 + (0.02 * math.sin(_elasticAnimation.value * math.pi));
            return Transform.scale(
              scaleX: stretch,
              scaleY: 1.0 / stretch, // Conservation of mass (Liquid feel)
              child: child,
            );
          },
          child: Container(
            height: barHeight,
            constraints: const BoxConstraints(maxWidth: 420),
            alignment: Alignment.center,
            // Deep Shadow for "Floating" depth
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: Colors.blue.withOpacity(0.05), // Subtle ambient glow
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 1. Frosted Glass Layer
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                    child: Container(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),

                  // 2. Convex Lens Gradient (Optical Illusion)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),

                  // 3. Specular Reflection & Rim Light (Custom Painter)
                  CustomPaint(
                    painter: LiquidGlassPainter(),
                  ),

                  // 4. Content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(widget.items.length, (index) {
                      return _LiquidNavItem(
                        item: widget.items[index],
                        isSelected: widget.selectedIndex == index,
                        onTap: () => widget.onItemTapped(index),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(rect);
    
    canvas.drawRRect(rrect.inflate(-1), paintGlow);
    
    // Specular Highlight (The "Liquid" shine)
    final path = Path();
    path.moveTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.3, size.width * 0.7, 0);
    
    final paintSpec = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.8),
        radius: 0.5,
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(rect);
      
    canvas.drawPath(path, paintSpec);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LiquidNavItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isSelected;
  final VoidCallback onTap;

  const _LiquidNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticFeedback.lightImpact(); // More subtle haptic for "Liquid" feel
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        height: 60,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            final double scale = 1.0 + (value * 0.3); // Zoom effect
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: scale,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glow behind active icon
                      if (value > 0.1)
                        Opacity(
                          opacity: value.clamp(0.0, 0.5),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      Icon(
                        item['icon'] as IconData,
                        color: Color.lerp(
                          Colors.black45,
                          Colors.black,
                          value,
                        ),
                        size: 26,
                      ),
                    ],
                  ),
                ),
                // Liquid Dot
                if (value > 0.05) ...[
                   const SizedBox(height: 6),
                   Opacity(
                    opacity: value.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 10),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
