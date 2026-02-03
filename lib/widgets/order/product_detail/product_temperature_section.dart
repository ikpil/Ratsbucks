import 'package:flutter/material.dart';

class ProductTemperatureSection extends StatelessWidget {
  final bool isIce;
  final ValueChanged<bool> onToggle;

  const ProductTemperatureSection({
    super.key,
    required this.isIce,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTempOption('Hot', !isIce, Colors.redAccent)),
          Expanded(child: _buildTempOption('Ice', isIce, Colors.blueAccent)),
        ],
      ),
    );
  }

  Widget _buildTempOption(String label, bool isSelected, Color activeColor) {
    return GestureDetector(
      onTap: () => onToggle(label == 'Ice'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[500],
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
