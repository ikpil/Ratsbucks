import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/pay_card_carousel.dart';
import '../../widgets/pay_method_list.dart';

class PayView extends StatelessWidget {
  const PayView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> registeredCards = [
      {
        'type': 'Credit Card',
        'title': 'Rats Card',
        'number': '**** **** **** 1234',
        'balance': '₩ 54,000',
        'color': const Color(0xFF1E3932),
        'icon': Icons.credit_card,
      },
      {
        'type': 'Bitcoin',
        'title': 'My Crypto Wallet',
        'number': '0.0423 BTC',
        'balance': '₩ 2,450,000',
        'color': const Color(0xFFF7931A),
        'icon': Icons.currency_bitcoin,
      },
      {
        'type': 'Bank Account',
        'title': 'Star Bank',
        'number': '123-456-7890',
        'balance': 'Auto-Charge',
        'color': const Color(0xFF00704A),
        'icon': Icons.account_balance,
      },
    ];

    final List<Map<String, dynamic>> addMethods = [
      {
        'icon': Icons.credit_card_rounded,
        'title': '신용카드 등록',
        'subtitle': '간편하게 카드를 등록하고 사용하세요',
        'color': Colors.blue.shade600,
        'onTap': () {},
      },
      {
        'icon': Icons.account_balance_rounded,
        'title': '계좌 연결',
        'subtitle': '은행 계좌를 등록하여 직불 결제하세요',
        'color': Colors.teal.shade600,
        'onTap': () {},
      },
      {
        'icon': Icons.contactless_rounded,
        'title': 'Samsung Pay',
        'subtitle': 'Samsung Pay 연결하기',
        'color': const Color(0xFF1428A0),
        'onTap': () {},
      },
      {
        'icon': Icons.apple,
        'title': 'Apple Pay',
        'subtitle': 'Apple Pay로 빠르고 안전하게',
        'color': Colors.black,
        'onTap': () {},
      },
      {
        'icon': Icons.face,
        'title': '페이코',
        'subtitle': '페이코로 빠르고 안전하게',
        'color': Colors.black,
        'onTap': () {},
      },
      {
        'icon': Icons.face,
        'title': '쓱페이',
        'subtitle': '쓱!쓱! 빠르고 안전하게',
        'color': Colors.black,
        'onTap': () {},
      },
      {
        'icon': Icons.currency_bitcoin_rounded,
        'title': '암호화폐 연결',
        'subtitle': '비트코인 등 코인 지갑을 연결합니다',
        'color': Colors.orange.shade700,
        'onTap': () {},
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom App Bar
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              centerTitle: false, // 좌측 정렬 명시
              backgroundColor: const Color(0xFFF9F9F9),
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                title: const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(color: const Color(0xFFF9F9F9)),
              ),
            ),

            // Registered Cards Carousel
            SliverToBoxAdapter(
              child: PayCardCarousel(cards: registeredCards),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Add New Method Section
            SliverToBoxAdapter(
              child: PayMethodList(methods: addMethods),
            ),
          ],
        ),
      ),
    );
  }
}
