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
        height: 70,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
          duration: Duration(milliseconds: isSelected ? 400 : 200),
          curve: isSelected ? Curves.elasticOut : Curves.easeOut,
          builder: (context, value, child) {
            final double iconScale = 1.0 + (value * 0.1);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -4 * value),
                  child: Transform.scale(
                    scale: iconScale,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (value > 0.1)
                          Opacity(
                            opacity: value.clamp(0.0, 0.4),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Icon(
                          item['icon'] as IconData,
                          color: Color.lerp(Colors.black45, Colors.black, value),
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                if (value > 0.1)
                  Transform.translate(
                    offset: Offset(0, (1 - value) * 5),
                    child: Opacity(
                      opacity: value.clamp(0.0, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          item['label'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
