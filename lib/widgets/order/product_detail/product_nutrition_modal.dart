import 'package:flutter/material.dart';

class ProductNutritionModal extends StatelessWidget {
  const ProductNutritionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        height: 600, // 모달 높이 설정
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // 드래그 핸들
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            
            // 타이틀
            const Text(
              '제품 영양 정보',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 탭 바
            const TabBar(
              labelColor: Color(0xFF00704A),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF00704A),
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              tabs: [
                Tab(text: 'Tall'),
                Tab(text: 'Grande'),
                Tab(text: 'Venti'),
              ],
            ),

            // 탭 뷰 (각 사이즈별 정보)
            Expanded(
              child: TabBarView(
                children: [
                  _buildNutritionList('Tall'),
                  _buildNutritionList('Grande'),
                  _buildNutritionList('Venti'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionList(String size) {
    // 더미 데이터 생성 (사이즈별로 값을 다르게 설정)
    double multiplier = 1.0;
    if (size == 'Grande') multiplier = 1.3;
    if (size == 'Venti') multiplier = 1.6;

    final nutrients = [
      {'label': '칼로리', 'value': (150 * multiplier).round().toString(), 'unit': 'kcal'},
      {'label': '탄수화물', 'value': (20 * multiplier).round().toString(), 'unit': 'g'},
      {'label': '당류', 'value': (15 * multiplier).round().toString(), 'unit': 'g'},
      {'label': '나트륨', 'value': (70 * multiplier).round().toString(), 'unit': 'mg'},
      {'label': '단백질', 'value': (5 * multiplier).round().toString(), 'unit': 'g'},
      {'label': '지방', 'value': (3 * multiplier).round().toString(), 'unit': 'g'},
      {'label': '콜레스테롤', 'value': (10 * multiplier).round().toString(), 'unit': 'mg'},
      {'label': '트랜스지방', 'value': '0', 'unit': 'g'},
      {'label': '포화지방', 'value': (1 * multiplier).round().toString(), 'unit': 'g'},
      {'label': '카페인', 'value': (150 * multiplier).round().toString(), 'unit': 'mg'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_drink_rounded, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  size == 'Tall' ? '355ml (12 fl oz)' : 
                  size == 'Grande' ? '473ml (16 fl oz)' : '591ml (20 fl oz)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2열로 배치하여 가독성 확보
              childAspectRatio: 2.5, // 가로로 긴 박스 형태
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: nutrients.length,
            itemBuilder: (context, index) {
              return _buildNutritionItem(nutrients[index]);
            },
          ),
          const SizedBox(height: 24),
          Text(
            '* 1일 영양성분 기준치에 대한 비율(%)은 2,000kcal 기준이므로 개인의 필요 열량에 따라 다를 수 있습니다.',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(Map<String, String> data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data['label']!,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data['value'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: ' ${data['unit']}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
