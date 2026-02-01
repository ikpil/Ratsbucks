import 'package:flutter/material.dart';
import 'package:my_app/models/menu_data.dart';

class OrderSubCategoryList extends StatelessWidget {
  final int categoryIndex;
  final Function(String title, List<Map<String, dynamic>> items) onCategoryTap;

  const OrderSubCategoryList({
    super.key,
    required this.categoryIndex,
    required this.onCategoryTap,
  });

  Map<String, List<Map<String, dynamic>>> get _menuData {
    switch (categoryIndex) {
      case 0:
        return MenuData.beverageMenu;
      case 1:
        return MenuData.foodMenu;
      case 2:
        return MenuData.goodsMenu;
      default:
        return MenuData.beverageMenu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuData = _menuData;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
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
              onTap: () => onCategoryTap(category, items),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Representative Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.asset(
                        _getImagePathForCategory(category),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey.shade100,
                            child: Icon(
                              _getIconForCategory(category),
                              color: Colors.grey.shade400,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Representative Name & English Name
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getEnglishCategoryName(category),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Arrow Icon
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey.shade300,
                        size: 16,
                      ),
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

  String _getImagePathForCategory(String category) {
    String filename = 'cold_brew.jpg'; // Default
    if (category.contains('콜드 브루'))
      filename = 'cold_brew.jpg';
    else if (category.contains('에스프레소'))
      filename = 'espresso.jpg';
    else if (category.contains('프라푸치노'))
      filename = 'frappuccino.jpg';
    else if (category.contains('블렌디드'))
      filename = 'blended.jpg';
    else if (category.contains('티'))
      filename = 'tea.jpg';
    else if (category.contains('케이크'))
      filename = 'cake.jpg';
    else if (category.contains('샌드위치'))
      filename = 'sandwich.jpg';
    else if (category.contains('브레드'))
      filename = 'bread.jpg';
    else if (category.contains('과일'))
      filename = 'fruit.jpg';
    else if (category.contains('머그'))
      filename = 'mug.jpg';
    else if (category.contains('텀블러')) filename = 'tumbler.jpg';

    return 'assets/images/categories/$filename';
  }

  IconData _getIconForCategory(String category) {
    if (category.contains('콜드') || category.contains('에스프레소'))
      return Icons.coffee_rounded;
    if (category.contains('프라푸치노') || category.contains('블렌디드'))
      return Icons.local_drink_rounded;
    if (category.contains('티')) return Icons.emoji_food_beverage_rounded;
    if (category.contains('케이크') || category.contains('브레드'))
      return Icons.cake_rounded;
    if (category.contains('샌드위치')) return Icons.lunch_dining_rounded;
    if (category.contains('과일') || category.contains('요거트'))
      return Icons.rice_bowl_rounded;
    if (category.contains('머그') || category.contains('텀블러'))
      return Icons.coffee_maker_rounded;
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
