import 'package:flutter/material.dart';
import 'package:my_app/models/menu_data.dart';

class OrderCategoryList extends StatelessWidget {
  final int categoryIndex;
  final Function(String title, List<Map<String, dynamic>> items) onCategoryTap;

  const OrderCategoryList({
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
