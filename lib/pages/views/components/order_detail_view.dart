import 'package:flutter/material.dart';

class OrderDetailView extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const OrderDetailView({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 120),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 32, thickness: 0.5),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Menu Image
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.coffee_rounded,
                    color: Colors.grey.shade300,
                    size: 42,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Menu Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['en'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['price'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00704A),
                      ),
                    ),
                  ],
                ),
              ),
              // Like Button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded),
                color: Colors.grey.shade400,
                splashRadius: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}
