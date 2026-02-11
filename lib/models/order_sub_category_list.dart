import 'order_sub_category.dart';

class OrderSubCategoryList {
  // 음료 서브 카테고리
  static const List<OrderSubCategory> beverageCategories = [
    OrderSubCategory('콜드 브루'),
    OrderSubCategory('에스프레소'),
    OrderSubCategory('프라푸치노'),
    OrderSubCategory('블렌디드'),
    OrderSubCategory('티 (Tea)'),
    OrderSubCategory('브루드 커피'),
    OrderSubCategory('피지오'),
    OrderSubCategory('리프레셔'),
    OrderSubCategory('미니 음료'),
    OrderSubCategory('병음료'),
    OrderSubCategory('에이드'),
  ];

  // 푸드 서브 카테고리
  static const List<OrderSubCategory> foodCategories = [
    OrderSubCategory('케이크'),
    OrderSubCategory('샌드위치 & 샐러드'),
    OrderSubCategory('브레드'),
    OrderSubCategory('과일 & 요거트'),
    OrderSubCategory('스낵 & 미니 디저트'),
    OrderSubCategory('아이스크림'),
    OrderSubCategory('수프'),
    OrderSubCategory('브런치'),
    OrderSubCategory('초콜릿'),
    OrderSubCategory('마카롱'),
  ];

  // 상품 서브 카테고리
  static const List<OrderSubCategory> goodsCategories = [
    OrderSubCategory('머그 & 글라스'),
    OrderSubCategory('텀블러 & 보온병'),
    OrderSubCategory('커피 용품'),
    OrderSubCategory('원두'),
    OrderSubCategory('비아 (VIA)'),
    OrderSubCategory('티 패키지'),
    OrderSubCategory('시럽 & 소스'),
    OrderSubCategory('라이프스타일'),
    OrderSubCategory('기프트 카드'),
    OrderSubCategory('액세서리'),
  ];
}
