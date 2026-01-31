import 'package:flutter/material.dart';
import 'pay_add_button.dart';

class PayMethodList extends StatelessWidget {
  final List<Map<String, dynamic>> methods;

  const PayMethodList({
    super.key,
    required this.methods,
  });

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
          ...methods.map((method) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PayAddButton(
                  icon: method['icon'] as IconData,
                  title: method['title'] as String,
                  subtitle: method['subtitle'] as String,
                  color: method['color'] as Color,
                  onTap: method['onTap'] as VoidCallback? ?? () {},
                ),
              )),
          const SizedBox(height: 200), // Bottom padding for navigation bar
        ],
      ),
    );
  }
}
