import 'package:flutter/material.dart';
import 'dart:ui';

class QuickOrderSection extends StatelessWidget {
  const QuickOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Quick Order',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                '최근 주문',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: PageView.builder(
                  padEnds: false,
                  controller: PageController(
                    viewportFraction: 0.88,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, horizontalIndex) {
                    final quickOrderItems = [
                      {
                        'name': '아이스 카페 아메리카노',
                        'location': '역삼대로점',
                        'options': ['Grande', '개인컵', '얼음 많이', '샷 추가'],
                        'color': Colors.brown,
                        'icon': Icons.coffee,
                      },
                      {
                        'name': '스타벅스 돌체 라떼',
                        'location': '강남R점',
                        'options': ['Tall', '매장컵', '무지방 우유', '디카페인'],
                        'color': Colors.orangeAccent,
                        'icon': Icons.local_cafe,
                      },
                      {
                        'name': '자바 칩 프라푸치노',
                        'location': '삼성현대힐점',
                        'options': ['Venti', '일회용컵', '휘핑 많이', '초콜릿 드리즐'],
                        'color': Colors.brown.shade800,
                        'icon': Icons.cookie,
                      },
                    ];
                    final item = quickOrderItems[
                        horizontalIndex % quickOrderItems.length];

                    return Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Image Section
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.1),
                              borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(16)),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor:
                                    (item['color'] as Color).withOpacity(0.2),
                                child: Icon(
                                  item['icon'] as IconData,
                                  color: item['color'] as Color,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          // Content Section
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item['name'] as String,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const Icon(Icons.favorite_border,
                                          size: 20, color: Colors.grey),
                                    ],
                                  ),
                                  Text(
                                    (item['options'] as List<String>)
                                        .join(' | '),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item['location'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF00704A),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                      ),
                                      child: const Text(
                                        '바로 주문하기',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
