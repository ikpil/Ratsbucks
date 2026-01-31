import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

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
                    bottom: 30,
                    child: _RotatingWelcomeMessage(opacity: opacity),
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
  double get maxExtent =>
      197; // 260 * 0.7 = 182 + 15(padding adjustments) = ~197

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _RotatingWelcomeMessage extends StatefulWidget {
  final double opacity;

  const _RotatingWelcomeMessage({required this.opacity});

  @override
  State<_RotatingWelcomeMessage> createState() =>
      _RotatingWelcomeMessageState();
}

class _RotatingWelcomeMessageState extends State<_RotatingWelcomeMessage> {
  int _index = 0;
  Timer? _timer;

  final List<Map<String, String>> _messages = [
    {
      'title': '안녕하세요 최익필님',
      'subtitle': '오늘도 랫츠벅스와 함께\n활기찬 하루 시작하세요! ☕️',
    },
    {
      'title': '반가워요 최익필님',
      'subtitle': '당신을 위한 특별한\n커피가 준비되어 있어요! 🌟',
    },
    {
      'title': '어서오세요 최익필님',
      'subtitle': '잠시 휴식이 필요할 땐\n랫츠벅스 어떠세요? 🍀',
    },
    {
      'title': '환영합니다 최익필님',
      'subtitle': '기분 좋은 하루가\n되길 응원할게요! ✨',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _index = (_index + 1) % _messages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final msg = _messages[_index];

    return Opacity(
      opacity: widget.opacity,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        // Use a simple Fade for the switch, the content handles the entrance animation
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _WelcomeMessageContent(
          key: ValueKey<int>(_index),
          title: msg['title']!,
          subtitle: msg['subtitle']!,
        ),
      ),
    );
  }
}

class _WelcomeMessageContent extends StatefulWidget {
  final String title;
  final String subtitle;

  const _WelcomeMessageContent({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_WelcomeMessageContent> createState() => _WelcomeMessageContentState();
}

class _WelcomeMessageContentState extends State<_WelcomeMessageContent> {
  String _displayTitle = '';
  String _displaySubtitle = '';
  bool _showIcon = false;
  Timer? _typingTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    // Initial delay before typing starts
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      _typingTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          // 1. Type Title
          if (_currentIndex < widget.title.length) {
            _displayTitle = widget.title.substring(0, _currentIndex + 1);
            _currentIndex++;
          }
          // 2. Show Icon
          else if (_currentIndex == widget.title.length) {
            _showIcon = true;
            _currentIndex++;
          }
          // 3. Type Subtitle
          else {
            int subtitleIndex = _currentIndex - (widget.title.length + 1);
            if (subtitleIndex < widget.subtitle.length) {
              _displaySubtitle =
                  widget.subtitle.substring(0, subtitleIndex + 1);
              _currentIndex++;
            } else {
              timer.cancel();
            }
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              _displayTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_showIcon) ...[
              const SizedBox(width: 8),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Icon(
                  Icons.waving_hand_rounded,
                  color: Colors.amber.shade300,
                  size: 22,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          _displaySubtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
