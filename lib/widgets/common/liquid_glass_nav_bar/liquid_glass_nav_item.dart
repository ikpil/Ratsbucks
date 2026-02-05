import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LiquidGlassNavItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isSelected;
  final VoidCallback onTap;

  const LiquidGlassNavItem({
    super.key,
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
          duration: Duration(milliseconds: isSelected ? 400 : 100),
          curve: isSelected ? Curves.elasticOut : Curves.elasticIn,
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
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 3,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      Icon(
                        item['icon'] as IconData,
                        color: Color.lerp(Colors.black45, Colors.black, value),
                        size: 30,
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
                            ),
                          ],
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
