import 'package:flutter/material.dart';
import '../../models/shop_item.dart';
import 'shop_detail_app_bar.dart';
import 'shop_detail_content.dart';
import 'shop_detail_bottom_bar.dart';

class ShopProductDetail extends StatelessWidget {
  final ShopItem item;

  const ShopProductDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          ShopDetailAppBar(item: item),
          ShopDetailContent(item: item),
        ],
      ),
      bottomSheet: const ShopDetailBottomBar(),
    );
  }
}
