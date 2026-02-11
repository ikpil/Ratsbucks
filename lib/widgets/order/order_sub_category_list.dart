import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../models/order_item_list.dart';

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
        return OrderItemList.beverageMenu;
      case 1:
        return OrderItemList.foodMenu;
      case 2:
        return OrderItemList.goodsMenu;
      default:
        return OrderItemList.beverageMenu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuData = _menuData;

    return ListView.builder(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
        OrderItemList.categoryDetails[widget.category] ?? {'en': '', 'image': ''};
    final englishName = details['en'] ?? '';
    final imagePath = details['image'] ?? '';

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.98),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.08),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(1.0),
                      Colors.white.withOpacity(0.92),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Image Area (Embossed Circle)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.03),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: const Offset(-2, -2),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Colors.grey.shade400,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    // Text Area
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            englishName,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.2,
                            ),
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
          ),
        ),
      ),
    );
  }
}
