import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ... (Menu Data: Keep the same data structure for now)
  final Map<String, List<Map<String, dynamic>>> _beverageMenu = {
    '콜드 브루': [
      {'name': '나이트로 콜드 브루', 'price': '6,000', 'en': 'Nitro Cold Brew'},
      {'name': '돌체 콜드 브루', 'price': '6,000', 'en': 'Dolce Cold Brew'},
      {'name': '콜드 브루', 'price': '4,900', 'en': 'Cold Brew'},
      {'name': '바닐라 크림 콜드 브루', 'price': '5,800', 'en': 'Vanilla Cream Cold Brew'},
    ],
    '에스프레소': [
      {'name': '아메리카노', 'price': '4,500', 'en': 'Caffe Americano'},
      {'name': '카페 라떼', 'price': '5,000', 'en': 'Caffe Latte'},
      {'name': '카푸치노', 'price': '5,000', 'en': 'Cappuccino'},
      {'name': '카라멜 마키아또', 'price': '5,900', 'en': 'Caramel Macchiato'},
      {'name': '스타벅스 돌체 라떼', 'price': '5,900', 'en': 'Starbucks Dolce Latte'},
    ],
    '프라푸치노': [
      {'name': '자바 칩 프라푸치노', 'price': '6,300', 'en': 'Java Chip Frappuccino'},
      {'name': '카라멜 프라푸치노', 'price': '5,900', 'en': 'Caramel Frappuccino'},
      {'name': '에스프레소 프라푸치노', 'price': '5,500', 'en': 'Espresso Frappuccino'},
      {'name': '제주 말차 크림 프라푸치노', 'price': '6,300', 'en': 'Jeju Matcha Cream Frappuccino'},
    ],
    '블렌디드': [
      {'name': '망고 바나나 블렌디드', 'price': '6,300', 'en': 'Mango Banana Blended'},
      {'name': '딸기 딜라이트 요거트 블렌디드', 'price': '6,300', 'en': 'Strawberry Delight Yogurt Blended'},
    ],
    '티 (Tea)': [
      {'name': '자몽 허니 블랙 티', 'price': '5,700', 'en': 'Grapefruit Honey Black Tea'},
      {'name': '유자 민트 티', 'price': '5,900', 'en': 'Yuaja Mint Tea'},
      {'name': '제주 유기농 말차로 만든 라떼', 'price': '6,100', 'en': 'Jeju Matcha Latte'},
      {'name': '차이 티 라떼', 'price': '5,500', 'en': 'Chai Tea Latte'},
    ],
    '디카페인 커피': [
      {'name': '디카페인 아메리카노', 'price': '4,800', 'en': 'Decaf Caffe Americano'},
      {'name': '디카페인 카페 라떼', 'price': '5,300', 'en': 'Decaf Caffe Latte'},
    ],
    '리저브 에스프레소': [
      {'name': '리저브 바크 초콜릿 라떼', 'price': '7,000', 'en': 'Reserve Bark Chocolate Latte'},
      {'name': '리저브 아메리카노', 'price': '6,000', 'en': 'Reserve Americano'},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> _foodMenu = {
    '케이크': [
      {'name': '부드러운 생크림 카스텔라', 'price': '4,500', 'en': 'Fresh Cream Castella'},
      {'name': '클라우드 치즈 케이크', 'price': '5,500', 'en': 'Cloud Cheese Cake'},
      {'name': '7 레이어 가나슈 케이크', 'price': '5,700', 'en': '7 Layer Ganache Cake'},
      {'name': '마스카포네 티라미수', 'price': '5,900', 'en': 'Mascarpone Tiramisu'},
    ],
    '샌드위치 & 샐러드': [
      {'name': 'B.E.L.T. 샌드위치', 'price': '5,900', 'en': 'B.E.L.T. Sandwich'},
      {'name': '에그 에그 샌드위치', 'price': '4,400', 'en': 'Egg Egg Sandwich'},
      {'name': '바비큐 치킨 치즈 치아바타', 'price': '5,800', 'en': 'BBQ Chicken Cheese Ciabatta'},
      {'name': '콥 & 화이트 샐러드 밀 박스', 'price': '6,500', 'en': 'Cobb & White Salad Meal Box'},
    ],
    '브레드': [
      {'name': '하트 파이', 'price': '3,200', 'en': 'Heart Pie'},
      {'name': '미니 클래식 스콘', 'price': '4,000', 'en': 'Mini Classic Scone'},
      {'name': '베이글 (플레인/블루베리)', 'price': '3,000', 'en': 'Bagel'},
    ],
    '과일 & 요거트': [
      {'name': '하루 한 컵 RED', 'price': '2,600', 'en': 'Fruit Cup RED'},
      {'name': '오가닉 그릭 요거트', 'price': '3,900', 'en': 'Organic Greek Yogurt'},
    ],
    '스낵': [
      {'name': '다크 초콜릿 카우보이 쿠키', 'price': '2,800', 'en': 'Dark Chocolate Cowboy Cookie'},
      {'name': '한입에 쏙 고구마', 'price': '3,800', 'en': 'Sweet Potato Snacks'},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> _goodsMenu = {
    '머그 & 글라스': [
      {'name': '그린 사이렌 클래식 머그', 'price': '16,000', 'en': 'Green Siren Classic Mug'},
      {'name': 'SS 블랙 데비 머그', 'price': '22,000', 'en': 'SS Black Debbie Mug'},
      {'name': '더블월 글라스', 'price': '18,000', 'en': 'Double Wall Glass'},
    ],
    '텀블러 & 보온병': [
      {'name': 'SS 엘마 블랙 텀블러', 'price': '33,000', 'en': 'SS Elma Black Tumbler'},
      {'name': 'JNL 제트 블랙 보온병', 'price': '48,000', 'en': 'JNL Jet Black Thermos'},
      {'name': '미르 텀블러', 'price': '35,000', 'en': 'MiiR Tumbler'},
    ],
    '커피 용품': [
      {'name': '세라믹 드리퍼', 'price': '24,000', 'en': 'Ceramic Dripper'},
      {'name': '커피 프레스', 'price': '38,000', 'en': 'Coffee Press'},
    ],
    '패키지 티/커피': [
      {'name': '비아 파이크 플레이스 로스트', 'price': '12,800', 'en': 'VIA Pike Place Roast'},
      {'name': '제주 녹차 (15입)', 'price': '20,000', 'en': 'Jeju Green Tea (15ea)'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 24,
        title: const Text(
          'Order',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black, size: 28),
            padding: const EdgeInsets.only(right: 20),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade400,
              indicatorColor: const Color(0xFF00704A),
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: '음료'),
                Tab(text: '푸드'),
                Tab(text: '상품'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoryList(_beverageMenu, 'assets/images/coffee_icon.png'),
          _buildCategoryList(_foodMenu, 'assets/images/cake_icon.png'),
          _buildCategoryList(_goodsMenu, 'assets/images/mug_icon.png'),
        ],
      ),
    );
  }

  Widget _buildCategoryList(Map<String, List<Map<String, dynamic>>> menuData, String iconAsset) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      itemCount: menuData.keys.length,
      itemBuilder: (context, index) {
        final category = menuData.keys.elementAt(index);
        final items = menuData[category]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuListView(
                      title: category,
                      items: items,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      // Use Icon for now as assets might not exist
                      child: Icon(
                        _getIconForCategory(category),
                        color: const Color(0xFF00704A),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getEnglishCategoryName(category),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade300,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForCategory(String category) {
    if (category.contains('콜드') || category.contains('에스프레소')) return Icons.coffee_rounded;
    if (category.contains('프라푸치노') || category.contains('블렌디드')) return Icons.local_drink_rounded;
    if (category.contains('티')) return Icons.emoji_food_beverage_rounded;
    if (category.contains('케이크') || category.contains('브레드')) return Icons.cake_rounded;
    if (category.contains('샌드위치')) return Icons.lunch_dining_rounded;
    if (category.contains('과일') || category.contains('요거트')) return Icons.rice_bowl_rounded;
    if (category.contains('머그') || category.contains('텀블러')) return Icons.coffee_maker_rounded;
    return Icons.restaurant_menu_rounded;
  }

  String _getEnglishCategoryName(String category) {
    if (category == '콜드 브루') return 'Cold Brew';
    if (category == '에스프레소') return 'Espresso';
    if (category == '프라푸치노') return 'Frappuccino';
    if (category == '블렌디드') return 'Blended';
    if (category == '티 (Tea)') return 'Tea';
    if (category == '디카페인 커피') return 'Decaf Coffee';
    if (category == '리저브 에스프레소') return 'Reserve Espresso';
    if (category == '케이크') return 'Cake';
    if (category == '샌드위치 & 샐러드') return 'Sandwich & Salad';
    if (category == '브레드') return 'Bread';
    if (category == '과일 & 요거트') return 'Fruit & Yogurt';
    if (category == '스낵') return 'Snack';
    if (category == '머그 & 글라스') return 'Mug & Glass';
    if (category == '텀블러 & 보온병') return 'Tumbler';
    if (category == '커피 용품') return 'Coffee Equipment';
    if (category == '패키지 티/커피') return 'Packaged Tea/Coffee';
    return '';
  }
}

class MenuListView extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const MenuListView({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 32, thickness: 0.5),
        itemBuilder: (context, index) {
          final item = items[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Menu Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(40), // Circular image
                ),
                child: Icon(
                  Icons.coffee_rounded,
                  color: Colors.grey.shade300,
                  size: 40,
                ),
              ),
              const SizedBox(width: 20),
              // Menu Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['en'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['price'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00704A),
                      ),
                    ),
                  ],
                ),
              ),
              // Like Button
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded),
                color: Colors.grey.shade400,
              ),
            ],
          );
        },
      ),
    );
  }
}
