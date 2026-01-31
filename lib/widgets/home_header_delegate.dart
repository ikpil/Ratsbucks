import 'package:flutter/material.dart';
import 'dart:ui';

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
          // Background & Welcome Message
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 50, // Leave space for the bottom menu
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E3932), // Starbucks dark green
                    Color(0xFF00704A), // Starbucks green
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circles
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 60,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),

                  // Welcome Text
                  Positioned(
                    left: 24,
                    bottom: 40,
                    child: Opacity(
                      opacity: opacity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Text(
                                '안녕하세요',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.waving_hand_rounded,
                                color: Colors.amber.shade300,
                                size: 26,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '오늘도 랫츠벅스와 함께\n활기찬 하루 시작하세요! ☕️',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Menu (Pinned)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final menus = [
                      '추천 메뉴',
                      'What\'s New',
                      'Coupon',
                      '이벤트',
                      '매장 찾기',
                      '제휴 혜택'
                    ];
                    final isSelected = index == 0;

                    return Container(
                      margin: const EdgeInsets.only(right: 24),
                      alignment: Alignment.center,
                      child: Text(
                        menus[index],
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF00704A)
                              : Colors.grey[600],
                          fontSize: 15,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 260;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
