import 'package:flutter/material.dart';
import 'package:my_app/models/menu_data.dart';
import 'package:my_app/pages/views/components/order_category_list.dart';
import 'package:my_app/pages/views/components/order_category_tab.dart';
import 'package:my_app/pages/views/components/order_detail_view.dart';

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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: _detailTitle != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                  onPressed: _closeDetail,
                )
              : null,
          centerTitle: _detailTitle != null, // 상세 페이지일 땐 가운데 정렬
          titleSpacing: _detailTitle != null ? 0 : 24,
          title: Text(
            _detailTitle ?? 'Order',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: _detailTitle != null ? 18 : 28,
              letterSpacing: _detailTitle != null ? 0 : -0.5,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.black, size: 28),
              padding: const EdgeInsets.only(right: 20),
            ),
          ],
        ),
        body: _detailTitle != null
            ? OrderDetailView(items: _detailItems!)
            : Column(
                children: [
                  OrderCategoryTab(
                    selectedIndex: _selectedCategoryIndex,
                    categories: _mainCategories,
                    onCategoryTap: _onCategoryTap,
                  ),

                  const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),

                  Expanded(
                    child: PageView(
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
                ],
              ),
      ),
    );
  }

}
