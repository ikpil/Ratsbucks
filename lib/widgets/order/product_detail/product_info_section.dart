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
          '진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피',
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
        ),
      ],
    );
  }
}
