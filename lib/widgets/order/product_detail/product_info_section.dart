import 'package:flutter/material.dart';
import '../../../models/order_product.dart';

class ProductInfoSection extends StatelessWidget {
  final OrderProduct item;

  const ProductInfoSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.enName,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          item.description,
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
        ),
      ],
    );
  }
}
