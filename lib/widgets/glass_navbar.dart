import 'package:flutter/material.dart';
import 'dart:ui';

class GlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Map<String, dynamic>> items;

  const GlassNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / items.length;

                return Stack(
                  children: [
                    // Sliding Pill
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      left: selectedIndex * itemWidth,
                      top: 10,
                      width: itemWidth,
                      height: 50,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Icons & Text
                    Row(
                      children: List.generate(
                        items.length,
                        (index) => SizedBox(
                          width: itemWidth,
                          child: GestureDetector(
                            onTap: () => onItemTapped(index),
                            behavior: HitTestBehavior.opaque,
                            child: _buildNavItem(index),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = selectedIndex == index;
    final item = items[index];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
              builder: (context, value, child) {
                return Icon(
                  item['icon'],
                  color: Color.lerp(
                    Colors.black54,
                    const Color(0xFF007AFF),
                    value,
                  ),
                  size: 24 + (value * 4),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 4),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isSelected ? const Color(0xFF007AFF) : Colors.black54,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontFamily: '.SF Pro Text',
          ),
          child: Text(item['label']),
        ),
      ],
    );
  }
}
