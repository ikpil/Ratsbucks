import 'order_main_category_id.dart';
import 'order_sub_category_id.dart';

class OrderProduct {
  final String name;
  final String enName;
  final String description; // 상품 설명 추가
  final String price; // Using String to match existing data format ('6,000')
  final String imageUrl;
  final OrderMainCategoryId mainCategoryId;
  final OrderSubCategoryId subCategoryId;

  const OrderProduct({
    required this.name,
    required this.enName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.mainCategoryId,
    required this.subCategoryId,
  });

  int get priceInt => int.parse(price.replaceAll(',', ''));
}
