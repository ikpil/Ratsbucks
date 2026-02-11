import 'shop_item.dart';

class ShopItemList {
  static const List<String> categories = [
    '머그',
    '글라스',
    '텀블러',
    '보온병',
    '액세서리',
    '커피용품',
    '패키지 티',
  ];

  static const List<ShopItem> products = [
    ShopItem(
      name: 'SS 블랙 앤 골드 스탠리 보온병 500ml',
      price: '40,000',
      imageUrl: 'assets/images/products/coffee_traveler___dark_roast.png',
      category: '보온병',
      isBest: true,
    ),
    ShopItem(
      name: '그린 사이렌 클래식 머그 355ml',
      price: '18,000',
      imageUrl: 'assets/images/products/caffe_latte.png',
      category: '머그',
    ),
    ShopItem(
      name: 'SS 엘마 블랙 텀블러 473ml',
      price: '33,000',
      imageUrl: 'assets/images/products/iced_caffe_americano.png',
      category: '텀블러',
      isNew: true,
    ),
    ShopItem(
      name: '24 SS 스프링 팬시 텀블러 355ml',
      price: '31,000',
      imageUrl: 'assets/images/products/iced_caffe_latte.png',
      category: '텀블러',
      isNew: true,
    ),
    ShopItem(
      name: '블랙 사이렌 콜드컵 473ml',
      price: '21,000',
      imageUrl:
          'assets/images/products/cold_brew_with_nondairy_vanilla_sweet_cream_cold_foam.png',
      category: '텀블러',
    ),
    ShopItem(
      name: '화이트 사이렌 머그 237ml',
      price: '14,000',
      imageUrl: 'assets/images/products/espresso.png',
      category: '머그',
    ),
    ShopItem(
      name: '바리스타 앞치마',
      price: '28,000',
      imageUrl: 'assets/images/products/iced_black_tea_lemonade.png',
      category: '액세서리',
    ),
    ShopItem(
      name: '하우스 블렌드 250g',
      price: '15,000',
      imageUrl: 'assets/images/products/coffee_traveler___pike_place_roast.png',
      category: '패키지 티',
      isBest: true,
    ),
    ShopItem(
      name: '파이크 플레이스 로스트 250g',
      price: '15,000',
      imageUrl: 'assets/images/products/coffee_traveler___pike_place_roast.png',
      category: '패키지 티',
    ),
    ShopItem(
      name: '클래식 글라스 355ml',
      price: '16,000',
      imageUrl: 'assets/images/products/iced_coffee.png',
      category: '글라스',
    ),
  ];
}
