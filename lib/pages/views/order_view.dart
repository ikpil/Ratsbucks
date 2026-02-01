import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:my_app/models/menu_data.dart';
import 'package:my_app/pages/views/components/order_category_list.dart';
import 'package:my_app/pages/views/components/order_category_tab.dart';
import 'package:my_app/pages/views/components/order_detail_view.dart';
import 'package:my_app/widgets/rats_sliver_app_bar.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  final List<String> _mainCategories = ['음료', '푸드', '상품'];
  late PageController _pageController;

  // 상세 페이지 상태 관리를 위한 변수
  String? _detailTitle;
  List<Map<String, dynamic>>? _detailItems;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _openDetail(String title, List<Map<String, dynamic>> items) {
    setState(() {
      _detailTitle = title;
      _detailItems = items;
    });
  }

  void _closeDetail() {
    setState(() {
      _detailTitle = null;
      _detailItems = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 상세 페이지가 열려있으면 백 버튼으로 닫기 처리
    return PopScope(
      canPop: _detailTitle == null,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_detailTitle != null) {
          _closeDetail();
        }
      },
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: _detailTitle != null
            ? OrderDetailView(
                title: _detailTitle!,
                items: _detailItems!,
                onPop: _closeDetail,
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      RatsSliverAppBar(
                        title: 'Order',
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search,
                                color: Colors.black, size: 28),
                            padding: const EdgeInsets.only(right: 20),
                          ),
                        ],
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 61.0,
                          maxHeight: 61.0,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                OrderCategoryTab(
                                  selectedIndex: _selectedCategoryIndex,
                                  categories: _mainCategories,
                                  onCategoryTap: _onCategoryTap,
                                ),
                                const Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(0xFFF0F0F0)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      OrderCategoryList(
                        menuData: MenuData.beverageMenu,
                        onCategoryTap: _openDetail,
                        iconAsset: 'assets/images/coffee_icon.png',
                      ),
                      OrderCategoryList(
                        menuData: MenuData.foodMenu,
                        onCategoryTap: _openDetail,
                        iconAsset: 'assets/images/cake_icon.png',
                      ),
                      OrderCategoryList(
                        menuData: MenuData.goodsMenu,
                        onCategoryTap: _openDetail,
                        iconAsset: 'assets/images/mug_icon.png',
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
