import 'package:flutter/material.dart';

class SimilarProductSection extends StatelessWidget {
  final Map<String, dynamic> item;

  const SimilarProductSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '이 메뉴와 비슷한 상품',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('전체보기', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100],
                          image: item['image'] != null
                              ? DecorationImage(
                                  image: AssetImage(item['image']),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: item['image'] == null
                            ? Center(
                                child: Icon(Icons.coffee,
                                    size: 40, color: Colors.grey[300]))
                            : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['name'] ?? '추천 메뉴 ${index + 1}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${item['price'] ?? 4500}원',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
