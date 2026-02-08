import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/rats_sliver_app_bar.dart';
import '../../widgets/shop/shop_banner.dart';
import '../../widgets/shop/shop_category_list.dart';
import '../../widgets/shop/shop_horizontal_list.dart';
import '../../widgets/shop/shop_product_grid.dart';
import '../../widgets/shop/shop_section_header.dart';
import '../../models/shop_data.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            RatsSliverAppBar(
              title: 'Shop',
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SliverToBoxAdapter(child: ShopBanner()),
            SliverToBoxAdapter(
              child: ShopCategoryList(categories: ShopData.categories),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: ShopSectionHeader(
                title: 'New & Featured',
                onMoreTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ShopHorizontalList(
                items: ShopData.products
                    .where((item) => item.isNew || item.isBest)
                    .toList(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(
              child: ShopSectionHeader(title: 'All Products'),
            ),
            ShopProductGrid(items: ShopData.products),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}
