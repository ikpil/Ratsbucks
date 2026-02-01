import 'package:flutter/material.dart';
import 'package:my_app/models/menu_data.dart';

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // Force the background image to be taller than the item (120px) to allow parallax movement.
    // Setting a fixed height ensures consistent behavior regardless of image aspect ratio.
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
      height: 200.0, // Significantly taller than the card height
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    if (context.childCount == 0) return;

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
    final backgroundSize = context.getChildSize(0) ?? Size.zero;
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
        listItemContext != oldDelegate.listItemContext;
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
    final details =
        MenuData.categoryDetails[widget.category] ?? {'en': '', 'image': ''};
    final englishName = details['en'] ?? '';
    final imagePath = details['image'] ?? '';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 120, // Slightly reduced height for better proportion
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            // Text Content Area (Left Side - 60%)
            Expanded(
              flex: 6,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      englishName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Image Area (Right Side - 40% with Parallax)
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Flow(
                    delegate: ParallaxFlowDelegate(
                      scrollable: Scrollable.of(context),
                      listItemContext: context,
                    ),
                    children: [
                      Image.asset(
                        imagePath,
                        key: _backgroundImageKey,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.coffee, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Optional: Subtle separation line or shadow if needed
                  // But user asked for distinct areas, the cut is distinct enough.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
