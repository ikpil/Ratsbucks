import 'order_main_category.dart';
import 'order_main_category_id.dart';

class OrderMainCategoryList {
  static const List<OrderMainCategory> categories = [
    OrderMainCategory(id: OrderMainCategoryId.beverage, label: '음료'),
    OrderMainCategory(id: OrderMainCategoryId.food, label: '푸드'),
    OrderMainCategory(id: OrderMainCategoryId.goods, label: '상품'),
  ];
}
