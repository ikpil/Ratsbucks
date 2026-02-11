import 'package:flutter/material.dart';
import '../../models/shop_item.dart';
import 'shop_horizontal_item_card.dart';

class ShopHorizontalList extends StatelessWidget {
  final List<ShopItem> items;

  const ShopHorizontalList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Increased to provide room for shadow
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 30, // Breathing room for shadow
        ),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return ShopHorizontalItemCard(item: items[index]);
        },
      ),
    );
  }
}
