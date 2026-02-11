import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/rats_sliver_app_bar.dart';
import '../../widgets/shop/shop_banner.dart';
import '../../widgets/shop/shop_category_list.dart';
import '../../widgets/shop/shop_horizontal_list.dart';
import '../../widgets/shop/shop_product_grid.dart';
import '../../widgets/shop/shop_section_header.dart';
import '../../models/shop_item.dart';
import '../../models/shop_item_list.dart';
import '../../models/shop_item_category_list.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  String _selectedCategory = '전체';

  List<String> get _categories =>
      ['전체', ...ShopItemCategoryList.categories.map((e) => e.label)];

  List<ShopItem> get _filteredProducts {
    if (_selectedCategory == '전체') {
      return ShopItemList.products;
    }
    return ShopItemList.products
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
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
            SliverPersistentHeader(
              pinned: true,
              delegate: _ShopCategoryHeaderDelegate(
                child: ShopCategoryList(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onSelected: _onCategorySelected,
                ),
              ),
            ),
            if (_selectedCategory == '전체') ...[
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: ShopSectionHeader(
                  title: 'New & Featured',
                  onMoreTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: ShopHorizontalList(
                  items: ShopItemList.products
                      .where((item) => item.isNew || item.isBest)
                      .toList(),
                ),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: ShopSectionHeader(
                title: _selectedCategory == '전체'
                    ? 'All Products'
                    : '$_selectedCategory Products',
              ),
            ),
            ShopProductGrid(items: _filteredProducts),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

class _ShopCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _ShopCategoryHeaderDelegate({required this.child});

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: child);
  }

  @override
  bool shouldRebuild(covariant _ShopCategoryHeaderDelegate oldDelegate) {
    return true;
  }
}
