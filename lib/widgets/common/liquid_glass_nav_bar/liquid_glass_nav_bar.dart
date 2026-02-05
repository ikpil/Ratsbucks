import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'liquid_glass_painter.dart';
import 'liquid_glass_nav_item.dart';

class LiquidGlassNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Map<String, dynamic>> items;
  final bool isVisible;

  const LiquidGlassNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
    this.isVisible = true,
  });

  @override
  State<LiquidGlassNavBar> createState() => _LiquidGlassNavBarState();
}

class _LiquidGlassNavBarState extends State<LiquidGlassNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elasticAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    );
    _elasticAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void didUpdateWidget(LiquidGlassNavBar oldWidget) {
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
            final stretch =
                1.0 + (0.02 * math.sin(_elasticAnimation.value * math.pi));
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
                  // [Shadow Intensity] Adjust opacity (0.0 - 1.0) for clearer shadow. Currently set to 0.3.
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
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
                    filter: ui.ImageFilter.blur(
                      sigmaX: blurSigma,
                      sigmaY: blurSigma,
                    ),
                    // [Glass Transparency] Adjust opacity (0.0 - 1.0). Lower is more transparent.
                    child: Container(color: Colors.white.withOpacity(0.1)),
                  ),

                  // 2. Convex Lens Gradient (Optical Illusion)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // [Surface Gloss] Adjust opacity for reflection strength
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
                  CustomPaint(painter: LiquidGlassPainter()),

                  // 4. Content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(widget.items.length, (index) {
                      return LiquidGlassNavItem(
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
