class OrderItem {
  final String name;
  final int unitPrice;
  final int quantity;
  final bool isIce;
  final String selectedBean;

  const OrderItem({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.isIce,
    required this.selectedBean,
  });

  int get totalPrice => unitPrice * quantity;
}
