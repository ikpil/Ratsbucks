import 'package:flutter/material.dart';
import '../../models/menu_data.dart';

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
      padding: const EdgeInsets.only(top: 16, bottom: 120),
      itemCount: menuData.keys.length,
      itemBuilder: (context, index) {
        final category = menuData.keys.elementAt(index);
        final items = menuData[category]!;

        return SubCategoryCard(
          category: category,
          onTap: () => onCategoryTap(category, items),
        );
      },
    );
  }
}

class SubCategoryCard extends StatefulWidget {
  final String category;
  final VoidCallback onTap;

  const SubCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  State<SubCategoryCard> createState() => _SubCategoryCardState();
}

class _SubCategoryCardState extends State<SubCategoryCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final details =
        MenuData.categoryDetails[widget.category] ?? {'en': '', 'image': ''};
    final englishName = details['en'] ?? '';
    final imagePath = details['image'] ?? '';

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              // Image Area (Embossed Circle)
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5F5F5),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-2, -2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color(0xFFE0E0E0),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(
                        Icons.coffee,
                        size: 40,
                        color: Colors.brown.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Text Content Area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      englishName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9E9E9E),
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
