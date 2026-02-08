import 'package:flutter/material.dart';
import '../../models/shop_data.dart';

class ShopDetailAppBar extends StatelessWidget {
  final ShopItem item;

  const ShopDetailAppBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share_outlined, color: Colors.black),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: item.name,
          child: Container(
            color: Colors.grey.shade50,
            child: Image.asset(item.imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
