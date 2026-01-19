import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _categoryScrollController;
  late ScrollController _quickOrderScrollController;

  @override
  void initState() {
    super.initState();
    _categoryScrollController = ScrollController();
    _quickOrderScrollController = ScrollController();
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    _quickOrderScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 헤더 영역
          _buildHeader(),
          
          const SizedBox(height: 24),
          
          // 가로 스크롤 카테고리
          _buildCategoryScroll(),
          
          const SizedBox(height: 24),
          
          // 빠른 주문
          _buildQuickOrder(),
          
          const SizedBox(height: 24),
          
          // 추천 상품 섹션
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.brown.shade900,
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // 추천 상품 세로 리스트
          _buildRecommendedProducts(),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back! ☕',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.brown.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What would you like today?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.brown.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryScroll() {
    final categories = ['Reward', 'Coupon', 'Pay', 'Buddy Pass', 'Deals', 'Favorite', 'New']; 
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          _categoryScrollController.jumpTo(
            _categoryScrollController.offset - details.delta.dx,
          );
        },
        child: SingleChildScrollView(
          controller: _categoryScrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: List.generate(
              categories.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.brown.shade600
                        : Colors.brown.shade100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.brown.shade300,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: index == 0
                          ? Colors.white
                          : Colors.brown.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickOrder() {
    final quickOrders = [
      {'name': '아이스 카페 아메리카노', 'icon': '☕'},
      {'name': '더블 에스프레소 크림 라떼', 'icon': '🥛'},
      {'name': '브루드 커피', 'icon': '☕'},
      {'name': '브루드 커피 - 크리스마스 블렌드', 'icon': '🎄'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quick Order',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.brown.shade900,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              _quickOrderScrollController.jumpTo(
                _quickOrderScrollController.offset - details.delta.dx,
              );
            },
            child: SingleChildScrollView(
              controller: _quickOrderScrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: List.generate(
                  quickOrders.length,
                  (index) {
                    final order = quickOrders[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        width: 250,
                        height: 150,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.brown.shade200,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.08),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              order['icon'] as String,
                              style: const TextStyle(fontSize: 36),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: Text(
                                order['name'] as String,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown.shade900,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade600,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Order',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedProducts() {
    final products = [
      {
        'name': 'Caramel Macchiato',
        'price': '\$5.45',
        'icon': '☕',
        'color': Colors.brown.shade100,
      },
      {
        'name': 'Iced Vanilla Latte',
        'price': '\$4.95',
        'icon': '🧊',
        'color': Colors.blue.shade100,
      },
      {
        'name': 'Matcha Green Tea',
        'price': '\$5.75',
        'icon': '🍵',
        'color': Colors.green.shade100,
      },
      {
        'name': 'Chocolate Croissant',
        'price': '\$3.50',
        'icon': '🥐',
        'color': Colors.amber.shade100,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(
          products.length,
          (index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (product['color'] as Color),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.brown.shade200,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      product['icon'] as String,
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product['price'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.brown.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade600,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
