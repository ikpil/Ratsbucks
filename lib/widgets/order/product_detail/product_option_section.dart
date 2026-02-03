import 'package:flutter/material.dart';

class ProductOptionSection extends StatelessWidget {
  final String selectedBean;
  final ValueChanged<String> onBeanSelected;

  const ProductOptionSection({
    super.key,
    required this.selectedBean,
    required this.onBeanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '퍼스널 옵션',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text('원두 선택',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: ['블론드', '디카페인', '1/2디카페인'].map((option) {
            final isSelected = selectedBean == option;
            return InkWell(
              onTap: () => onBeanSelected(option),
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF00704A).withOpacity(0.05)
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF00704A)
                        : Colors.grey[300]!,
                    width: isSelected ? 1.5 : 1,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF00704A) : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
