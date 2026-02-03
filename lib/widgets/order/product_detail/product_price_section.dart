import 'package:flutter/material.dart';

class ProductPriceSection extends StatelessWidget {
  final dynamic price;
  final bool isIce;
  final ValueChanged<bool> onToggle;

  const ProductPriceSection({
    super.key,
    required this.price,
    required this.isIce,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${price ?? 4500}원',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              _buildTempOption('Hot', !isIce, Colors.redAccent),
              _buildTempOption('Ice', isIce, Colors.blueAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTempOption(String label, bool isSelected, Color activeColor) {
    return GestureDetector(
      onTap: () => onToggle(label == 'Ice'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[500],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
