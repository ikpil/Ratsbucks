import 'package:flutter/material.dart';
import '../../models/shop_data.dart';
import 'shop_item_card.dart';

class ShopProductGrid extends StatelessWidget {
  final List<ShopItem> items;

  const ShopProductGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.58,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return ShopItemCard(item: items[index]);
        }, childCount: items.length),
      ),
    );
  }
}
