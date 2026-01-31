import 'package:flutter/material.dart';
import 'pay_add_button.dart';

class PayMethodList extends StatelessWidget {
  const PayMethodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '결제 수단 추가',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          PayAddButton(
            icon: Icons.credit_card_rounded,
            title: '신용카드 등록',
            subtitle: '간편하게 카드를 등록하고 사용하세요',
            color: Colors.blue.shade600,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PayAddButton(
            icon: Icons.apple,
            title: 'Apple Pay',
            subtitle: 'Apple Pay로 빠르고 안전하게',
            color: Colors.black,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PayAddButton(
            icon: Icons.contactless_rounded,
            title: 'Samsung Pay',
            subtitle: 'Samsung Pay 연결하기',
            color: const Color(0xFF1428A0),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PayAddButton(
            icon: Icons.currency_bitcoin_rounded,
            title: '암호화폐 연결',
            subtitle: '비트코인 등 코인 지갑을 연결합니다',
            color: Colors.orange.shade700,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          PayAddButton(
            icon: Icons.account_balance_rounded,
            title: '계좌 연결',
            subtitle: '은행 계좌를 등록하여 직불 결제하세요',
            color: Colors.teal.shade600,
            onTap: () {},
          ),
          const SizedBox(height: 200), // Bottom padding for navigation bar
        ],
      ),
    );
  }
}
