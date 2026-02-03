import 'package:flutter/material.dart';

class ProductNutritionSection extends StatelessWidget {
  const ProductNutritionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final nutrients = [
      {'label': '칼로리', 'value': '10', 'unit': 'kcal'},
      {'label': '당류', 'value': '0', 'unit': 'g'},
      {'label': '나트륨', 'value': '5', 'unit': 'mg'},
      {'label': '단백질', 'value': '1', 'unit': 'g'},
      {'label': '카페인', 'value': '150', 'unit': 'mg'},
      {'label': '포화지방', 'value': '0', 'unit': 'g'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제품 영양 정보',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: nutrients.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nutrients[index]['label']!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: nutrients[index]['value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: ' ${nutrients[index]['unit']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
