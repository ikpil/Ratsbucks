import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int _selectedCategoryIndex = 0;
  final List<String> _mainCategories = ['음료', '푸드', '상품'];

  // Helper to duplicate data for scroll testing
  List<Map<String, dynamic>> _repeat(List<Map<String, dynamic>> list, int times) {
    return List<Map<String, dynamic>>.from(
      list.expand((element) => List.generate(times, (i) => element)),
    );
  }

  late final Map<String, List<Map<String, dynamic>>> _beverageMenu;
  late final Map<String, List<Map<String, dynamic>>> _foodMenu;
  late final Map<String, List<Map<String, dynamic>>> _goodsMenu;

  @override
  void initState() {
    super.initState();
    // Initialize with more data for scroll testing
    _beverageMenu = {
      '콜드 브루': _repeat([
        {'name': '나이트로 콜드 브루', 'price': '6,000', 'en': 'Nitro Cold Brew'},
        {'name': '돌체 콜드 브루', 'price': '6,000', 'en': 'Dolce Cold Brew'},
        {'name': '콜드 브루', 'price': '4,900', 'en': 'Cold Brew'},
        {'name': '바닐라 크림 콜드 브루', 'price': '5,800', 'en': 'Vanilla Cream Cold Brew'},
        {'name': '오트 콜드 브루', 'price': '5,800', 'en': 'Oat Cold Brew'},
        {'name': '제주 비자림 콜드 브루', 'price': '6,800', 'en': 'Jeju Forest Cold Brew'},
      ], 3),
      '에스프레소': _repeat([
        {'name': '아메리카노', 'price': '4,500', 'en': 'Caffe Americano'},
        {'name': '카페 라떼', 'price': '5,000', 'en': 'Caffe Latte'},
        {'name': '카푸치노', 'price': '5,000', 'en': 'Cappuccino'},
        {'name': '카라멜 마키아또', 'price': '5,900', 'en': 'Caramel Macchiato'},
        {'name': '스타벅스 돌체 라떼', 'price': '5,900', 'en': 'Starbucks Dolce Latte'},
        {'name': '바닐라 플랫 화이트', 'price': '5,900', 'en': 'Vanilla Flat White'},
        {'name': '카페 모카', 'price': '5,500', 'en': 'Caffe Mocha'},
        {'name': '화이트 초콜릿 모카', 'price': '5,900', 'en': 'White Chocolate Mocha'},
      ], 3),
      '프라푸치노': _repeat([
        {'name': '자바 칩 프라푸치노', 'price': '6,300', 'en': 'Java Chip Frappuccino'},
        {'name': '카라멜 프라푸치노', 'price': '5,900', 'en': 'Caramel Frappuccino'},
        {'name': '에스프레소 프라푸치노', 'price': '5,500', 'en': 'Espresso Frappuccino'},
        {'name': '제주 말차 크림 프라푸치노', 'price': '6,300', 'en': 'Jeju Matcha Cream Frappuccino'},
        {'name': '초콜릿 크림 칩 프라푸치노', 'price': '6,000', 'en': 'Chocolate Cream Chip Frappuccino'},
        {'name': '화이트 타이거 프라푸치노', 'price': '6,500', 'en': 'White Tiger Frappuccino'},
      ], 3),
      '블렌디드': _repeat([
        {'name': '망고 바나나 블렌디드', 'price': '6,300', 'en': 'Mango Banana Blended'},
        {'name': '딸기 딜라이트 요거트 블렌디드', 'price': '6,300', 'en': 'Strawberry Delight Yogurt Blended'},
        {'name': '피치 & 레몬 블렌디드', 'price': '6,300', 'en': 'Peach & Lemon Blended'},
      ], 4),
      '티 (Tea)': _repeat([
        {'name': '자몽 허니 블랙 티', 'price': '5,700', 'en': 'Grapefruit Honey Black Tea'},
        {'name': '유자 민트 티', 'price': '5,900', 'en': 'Yuaja Mint Tea'},
        {'name': '제주 유기농 말차로 만든 라떼', 'price': '6,100', 'en': 'Jeju Matcha Latte'},
        {'name': '차이 티 라떼', 'price': '5,500', 'en': 'Chai Tea Latte'},
        {'name': '얼 그레이 티', 'price': '4,500', 'en': 'Earl Grey Tea'},
        {'name': '히비스커스 블렌드 티', 'price': '4,500', 'en': 'Hibiscus Blend Tea'},
      ], 3),
    };

    _foodMenu = {
      '케이크': _repeat([
        {'name': '부드러운 생크림 카스텔라', 'price': '4,500', 'en': 'Fresh Cream Castella'},
        {'name': '클라우드 치즈 케이크', 'price': '5,500', 'en': 'Cloud Cheese Cake'},
        {'name': '7 레이어 가나슈 케이크', 'price': '5,700', 'en': '7 Layer Ganache Cake'},
        {'name': '마스카포네 티라미수', 'price': '5,900', 'en': 'Mascarpone Tiramisu'},
        {'name': '레드벨벳 크림치즈 케이크', 'price': '5,500', 'en': 'Red Velvet Cream Cheese Cake'},
        {'name': '블루베리 쿠키 치즈 케이크', 'price': '6,900', 'en': 'Blueberry Cookie Cheese Cake'},
      ], 3),
      '샌드위치 & 샐러드': _repeat([
        {'name': 'B.E.L.T. 샌드위치', 'price': '5,900', 'en': 'B.E.L.T. Sandwich'},
        {'name': '에그 에그 샌드위치', 'price': '4,400', 'en': 'Egg Egg Sandwich'},
        {'name': '바비큐 치킨 치즈 치아바타', 'price': '5,800', 'en': 'BBQ Chicken Cheese Ciabatta'},
        {'name': '콥 & 화이트 샐러드 밀 박스', 'price': '6,500', 'en': 'Cobb & White Salad Meal Box'},
        {'name': '쉬림프 코코넛 샐러드', 'price': '6,900', 'en': 'Shrimp Coconut Salad'},
      ], 3),
      '브레드': _repeat([
        {'name': '하트 파이', 'price': '3,200', 'en': 'Heart Pie'},
        {'name': '미니 클래식 스콘', 'price': '4,000', 'en': 'Mini Classic Scone'},
        {'name': '베이글 (플레인/블루베리)', 'price': '3,000', 'en': 'Bagel'},
        {'name': '버터 크루아상', 'price': '3,500', 'en': 'Butter Croissant'},
      ], 4),
    };

    _goodsMenu = {
      '머그 & 글라스': _repeat([
        {'name': '그린 사이렌 클래식 머그', 'price': '16,000', 'en': 'Green Siren Classic Mug'},
        {'name': 'SS 블랙 데비 머그', 'price': '22,000', 'en': 'SS Black Debbie Mug'},
        {'name': '더블월 글라스', 'price': '18,000', 'en': 'Double Wall Glass'},
        {'name': '헤리티지 핸들 머그', 'price': '19,000', 'en': 'Heritage Handle Mug'},
        {'name': '화이트 사이렌 머그', 'price': '14,000', 'en': 'White Siren Mug'},
      ], 3),
      '텀블러 & 보온병': _repeat([
        {'name': 'SS 엘마 블랙 텀블러', 'price': '33,000', 'en': 'SS Elma Black Tumbler'},
        {'name': 'JNL 제트 블랙 보온병', 'price': '48,000', 'en': 'JNL Jet Black Thermos'},
        {'name': '미르 텀블러', 'price': '35,000', 'en': 'MiiR Tumbler'},
        {'name': 'SS 콩코드 텀블러', 'price': '35,000', 'en': 'SS Concord Tumbler'},
        {'name': 'SS 루시 텀블러', 'price': '31,000', 'en': 'SS Lucy Tumbler'},
      ], 3),
      '커피 용품': _repeat([
        {'name': '세라믹 드리퍼', 'price': '24,000', 'en': 'Ceramic Dripper'},
        {'name': '커피 프레스', 'price': '38,000', 'en': 'Coffee Press'},
        {'name': '글라스 서버', 'price': '25,000', 'en': 'Glass Server'},
      ], 4),
    };
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
      ),
      body: Column(
        children: [
          // Custom Tab Bar (Quick Menu Style)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: _mainCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF00704A) : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF00704A) : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF00704A).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      _mainCategories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),

          // Main Content List
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedCategoryIndex) {
      case 0:
        return _buildCategoryList(_beverageMenu, 'assets/images/coffee_icon.png');
      case 1:
        return _buildCategoryList(_foodMenu, 'assets/images/cake_icon.png');
      case 2:
        return _buildCategoryList(_goodsMenu, 'assets/images/mug_icon.png');
      default:
        return Container();
    }
  }

  Widget _buildCategoryList(Map<String, List<Map<String, dynamic>>> menuData, String iconAsset) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 120),
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
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Icon(
                        _getIconForCategory(category),
                        color: const Color(0xFF00704A),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              letterSpacing: -0.3,
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
    if (category.contains('콜드 브루')) return 'Cold Brew';
    if (category.contains('에스프레소')) return 'Espresso';
    if (category.contains('프라푸치노')) return 'Frappuccino';
    if (category.contains('블렌디드')) return 'Blended';
    if (category.contains('티')) return 'Tea';
    if (category.contains('케이크')) return 'Cake';
    if (category.contains('샌드위치')) return 'Sandwich & Salad';
    if (category.contains('브레드')) return 'Bread';
    if (category.contains('과일')) return 'Fruit & Yogurt';
    if (category.contains('머그')) return 'Mug & Glass';
    if (category.contains('텀블러')) return 'Tumbler';
    return category;
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
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 32, thickness: 0.5),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Menu Image
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.coffee_rounded,
                      color: Colors.grey.shade300,
                      size: 42,
                    ),
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
                          letterSpacing: -0.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['en'] ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['price'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
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
                  splashRadius: 24,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
