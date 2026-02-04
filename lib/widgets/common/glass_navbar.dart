import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassNavBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // iOS 26 style constants for frosted glass and layout
    const double blurSigma = 30.0;
    const double barHeight = 64.0; 
    const double floatingBottomMargin = 34.0;
    
    return AnimatedSlide(
      offset: isVisible ? Offset.zero : const Offset(0, 1.5), // Hide downwards
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: floatingBottomMargin,
            left: 24,
            right: 24,
          ),
          child: Container(
            height: barHeight,
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 20,
                  spreadRadius: -2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      return _NavBarItem(
                        item: items[index],
                        isSelected: selectedIndex == index,
                        onTap: () => onItemTapped(index),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          HapticFeedback.selectionClick();
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 60,
        alignment: Alignment.center,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut, // Springy effect
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with Scale & Color transition
                Transform.scale(
                  scale: 1.0 + (value * 0.15), // 1.0 -> 1.15
                  child: Icon(
                    item['icon'] as IconData,
                    color: Color.lerp(
                      Colors.grey.shade500,
                      Colors.black87,
                      value,
                    ),
                    size: 26,
                  ),
                ),
                // Indicator Dot
                if (value > 0.05) ...[
                   const SizedBox(height: 4),
                   Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 5),
                      child: Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          shape: BoxShape.circle,
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
