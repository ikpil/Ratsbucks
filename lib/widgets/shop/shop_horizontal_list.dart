import 'package:flutter/material.dart';
import '../../models/shop_data.dart';
import 'shop_item_card.dart';

class ShopHorizontalList extends StatelessWidget {
  final List<ShopItem> items;

  const ShopHorizontalList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child: ShopItemCard(item: items[index], isHorizontal: true),
          );
        },
      ),
    );
  }
}
