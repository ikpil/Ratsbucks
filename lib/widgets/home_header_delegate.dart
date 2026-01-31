import 'package:flutter/material.dart';
import 'home_header_background.dart';
import 'home_header_greeting.dart';
import 'home_header_quick_menu.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percent = shrinkOffset / (maxExtent - minExtent);
    final double opacity = (1.0 - percent).clamp(0.0, 1.0);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Background
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 50, // Leave space for the bottom menu
            child: HomeHeaderBackground(),
          ),

          // Welcome Text (Greeting)
          Positioned(
            left: 24,
            bottom: 30 + 50, // 30 margin + 50 bottom menu height space
            child: HomeHeaderGreeting(opacity: opacity),
          ),

          // Bottom Menu (Quick Menu)
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: HomeHeaderQuickMenu(),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 197;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
