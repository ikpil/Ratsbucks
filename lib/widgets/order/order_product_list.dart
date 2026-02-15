import 'package:flutter/material.dart';
import '../../models/order_product.dart';
import '../common/rats_sliver_app_bar.dart';
import 'order_product_tile.dart';

class OrderProductList extends StatelessWidget {
  final String title;
  final List<OrderProduct> items;
  final VoidCallback onPop;

  const OrderProductList({
    super.key,
    required this.title,
    required this.items,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          RatsSliverAppBar(
            title: title,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: onPop,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Colors.black, size: 28),
                padding: const EdgeInsets.only(right: 20),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = items[index];
              return OrderProductTile(item: item);
            }, childCount: items.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
