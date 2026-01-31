import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'pay_card.dart';

class PayCardCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> cards;

  const PayCardCarousel({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
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
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return PayCard(
              type: card['type'] as String,
              title: card['title'] as String,
              number: card['number'] as String,
              balance: card['balance'] as String,
              color: card['color'] as Color,
              icon: card['icon'] as IconData,
            );
          },
        ),
      ),
    );
  }
}
