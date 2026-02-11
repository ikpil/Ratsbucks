class ShopItem {
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final bool isNew;
  final bool isBest;

  const ShopItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isNew = false,
    this.isBest = false,
  });
}
