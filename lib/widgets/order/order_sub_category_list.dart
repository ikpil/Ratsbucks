import 'package:flutter/material.dart';
import 'package:my_app/models/menu_data.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate scroll offset of the list item within the viewport
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Calculate the percentage of the item in the viewport
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Paint the child
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform: Matrix4.translationValues(0.0, childRect.top, 0.0),
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

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
          child: ParallaxSubCategoryCard(
            category: category,
            onTap: () => onCategoryTap(category, items),
          ),
        );
      },
    );
  }
}

class ParallaxSubCategoryCard extends StatefulWidget {
  final String category;
  final VoidCallback onTap;

  const ParallaxSubCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  State<ParallaxSubCategoryCard> createState() =>
      _ParallaxSubCategoryCardState();
}

class _ParallaxSubCategoryCardState extends State<ParallaxSubCategoryCard> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Background Image with Parallax
            Positioned.fill(
              left: 100, // Image takes right side mostly
              child: Flow(
                delegate: ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: _backgroundImageKey,
                ),
                children: [
                  Image.asset(
                    _getImagePathForCategory(widget.category),
                    key: _backgroundImageKey,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey.shade200),
                  ),
                ],
              ),
            ),

            // Gradient Overlay for Text Readability (Left to Right)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.8),
                      Colors.transparent,
                    ],
                    stops: const [0.4, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Text Content
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
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
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getEnglishCategoryName(widget.category),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00704A).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Menu',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00704A),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 14,
                            color: Color(0xFF00704A),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
