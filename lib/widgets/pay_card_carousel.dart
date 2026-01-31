import 'package:flutter/material.dart';
import 'dart:ui';
import 'pay_card.dart';

class PayCardCarousel extends StatelessWidget {
  const PayCardCarousel({super.key});

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
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: const [
            PayCard(
              type: 'Credit Card',
              title: 'Rats Card',
              number: '**** **** **** 1234',
              balance: '₩ 54,000',
              color: Color(0xFF1E3932),
              icon: Icons.credit_card,
            ),
            PayCard(
              type: 'Bitcoin',
              title: 'My Crypto Wallet',
              number: '0.0423 BTC',
              balance: '₩ 2,450,000',
              color: Color(0xFFF7931A),
              icon: Icons.currency_bitcoin,
            ),
            PayCard(
              type: 'Bank Account',
              title: 'Star Bank',
              number: '123-456-7890',
              balance: 'Auto-Charge',
              color: Color(0xFF00704A),
              icon: Icons.account_balance,
            ),
          ],
        ),
      ),
    );
  }
}
