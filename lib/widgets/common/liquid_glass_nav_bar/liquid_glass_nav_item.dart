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
    // Icon Size
    const double iconSize = 30.0;
    // Item Width = Double the Icon Width
    const double itemWidth = 60;
    // Glass covers the text, so height needs to be sufficient
    const double itemHeight = 75.0;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticFeedback.lightImpact(); // More subtle haptic for "Liquid" feel
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: itemWidth * 1.7,
        height: itemHeight,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
          duration: Duration(milliseconds: isSelected ? 400 : 200),
          curve: isSelected ? Curves.elasticOut : Curves.easeOut,
          builder: (context, value, child) {
            final double iconScale = 1.0 + (value * 0.1);

            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              children: [
                // 1. Content (Icon & Text)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -4 * value),
                      child: Transform.scale(
                        scale: iconScale,
                        child: Icon(
                          item['icon'] as IconData,
                          color: Color.lerp(Colors.black45, Colors.black, value),
                          size: iconSize,
                        ),
                      ),
                    ),
                    if (value > 0.1)
                      Transform.translate(
                        offset: Offset(0, (1 - value) * 5),
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              item['label'] as String,
                              style: const TextStyle(
                                fontSize: 11,
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
                ),

                // 2. Simple Transparent Pill Shape Overlay
                if (value > 0.05)
                  IgnorePointer(
                    child: Opacity(
                      opacity: value.clamp(0.0, 1.0),
                      child: Container(
                        width: itemWidth * 1.7, // Double the item width (120)
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.3), // Simple transparent fill
                          border: Border.all(
                            color: Colors.white.withOpacity(0.9),
                            width: 0.5,
                          ),
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
