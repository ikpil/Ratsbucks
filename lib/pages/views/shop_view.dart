import 'package:flutter/material.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.storefront_rounded,
            color: Colors.blue.shade400,
            size: 100,
          ),
          const SizedBox(height: 24),
          Text(
            'Shop',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Browse and discover products',
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
