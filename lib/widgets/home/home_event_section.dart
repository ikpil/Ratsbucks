import 'package:flutter/material.dart';
import '../common/bouncing_button.dart';

class HomeEventSection extends StatelessWidget {
  const HomeEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEventGroup(
          title: "What's New",
          description: "새로 나온 메뉴와 소식을 만나보세요",
          events: [
            {
              'title': '딸기 라떼의 계절이 돌아왔어요!',
              'date': '2024.01.01 - 2024.02.28',
              'color': Colors.red.shade100,
              'icon': Icons.local_drink,
            },
            {
              'title': '설날 맞이 기프트 카드 출시',
              'date': '2024.01.15 - 2024.02.10',
              'color': Colors.orange.shade100,
              'icon': Icons.card_giftcard,
            },
          ],
        ),
        _buildEventGroup(
          title: "Coupon & Benefit",
          description: "놓치지 말아야 할 혜택",
          events: [
            {
              'title': '사이렌 오더 주문 시 별 3개 적립',
              'date': '2024.01.20 - 2024.01.31',
              'color': Colors.green.shade100,
              'icon': Icons.star,
            },
            {
              'title': '텀블러 사용 시 에코별 추가 적립',
              'date': '상시 혜택',
              'color': Colors.blue.shade100,
              'icon': Icons.eco,
            },
          ],
        ),
        _buildEventGroup(
          title: "Recommendation",
          description: "회원님을 위한 특별한 추천",
          events: [
            {
              'title': '비오는 날엔 따뜻한 아메리카노',
              'date': '오늘의 추천',
              'color': Colors.brown.shade100,
              'icon': Icons.coffee,
            },
          ],
        ),
      ],
    );
  }

  Widget _buildEventGroup({
    required String title,
    required String description,
    required List<Map<String, dynamic>> events,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: events.map((event) {
                return BouncingButton(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 320,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Placeholder
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              color: event['color'],
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                event['icon'],
                                size: 64,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                        // Content
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  event['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 1.3,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  event['date'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
