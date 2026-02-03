import 'package:flutter/material.dart';

class ProductPriceSection extends StatelessWidget {
  final dynamic price;

  const ProductPriceSection({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        '${price ?? 4500}원',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
