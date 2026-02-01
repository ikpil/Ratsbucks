import 'package:flutter/material.dart';
import 'dart:async';

class HomeHeaderGreeting extends StatefulWidget {
  final double opacity;

  const HomeHeaderGreeting({super.key, required this.opacity});

  @override
  State<HomeHeaderGreeting> createState() => _HomeHeaderGreetingState();
}

class _HomeHeaderGreetingState extends State<HomeHeaderGreeting> {
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
