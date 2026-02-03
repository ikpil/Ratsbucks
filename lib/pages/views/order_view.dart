import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/order/order_sub_category_list.dart';
import '../../widgets/order/order_main_category_tab.dart';
import '../../widgets/order/order_product_list.dart';
import '../../widgets/common/rats_sliver_app_bar.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int _selectedCategoryIndex = 0;
  final List<String> _mainCategories = ['음료', '푸드', '상품'];

  // 상세 페이지 상태 관리를 위한 변수
  bool _showDetail = false;
  String? _detailTitle;
  List<Map<String, dynamic>>? _detailItems;

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _openDetail(String title, List<Map<String, dynamic>> items) {
    setState(() {
      _detailTitle = title;
      _detailItems = items;
      _showDetail = true;
    });
  }

  void _closeDetail() {
    setState(() {
      _showDetail = false;
      // 데이터는 애니메이션이 끝난 후 정리하거나 유지해도 무방함
    });
  }

  @override
  Widget build(BuildContext context) {
    // 상세 페이지가 열려있으면 백 버튼으로 닫기 처리
    return PopScope(
      canPop: !_showDetail,
      onPopInvoked: (didPop) {
        if (didPop) return;
        if (_showDetail) {
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
        child: Stack(
          children: [
            AnimatedSlide(
              offset: _showDetail ? const Offset(-0.3, 0) : Offset.zero,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: _showDetail,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: NestedScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                                  OrderMainCategoryTab(
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
                    body: OrderSubCategoryList(
                      categoryIndex: _selectedCategoryIndex,
                      onCategoryTap: _openDetail,
                    ),
                  ),
                ),
              ),
            ),
            if (_detailTitle != null)
              AnimatedSlide(
                offset: _showDetail ? Offset.zero : const Offset(1.0, 0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: OrderProductList(
                  title: _detailTitle!,
                  items: _detailItems!,
                  onPop: _closeDetail,
                ),
              ),
          ],
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
