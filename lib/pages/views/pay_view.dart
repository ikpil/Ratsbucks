import 'package:flutter/material.dart';

class PayView extends StatelessWidget {
  const PayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wallet_rounded,
            color: Colors.blue.shade400,
            size: 100,
          ),
          const SizedBox(height: 24),
          Text(
            'Pay',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Manage your payments securely',
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
