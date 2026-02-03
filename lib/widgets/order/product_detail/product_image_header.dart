import 'package:flutter/material.dart';

class ProductImageHeader extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool showTitle;

  const ProductImageHeader({
    super.key,
    required this.item,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 450.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showTitle ? 1.0 : 0.0,
        child: Text(
          item['name'] ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const [
          StretchMode.zoomBackground,
        ],
        background: item['image'] != null
            ? Image.asset(
                item['image'],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
              )
            : _buildPlaceholderImage(),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Icon(Icons.coffee, size: 80, color: Colors.grey[300]),
      ),
    );
  }
}
