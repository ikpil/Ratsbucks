class MenuData {
  static List<Map<String, dynamic>> _repeat(List<Map<String, dynamic>> list, int times) {
    return List<Map<String, dynamic>>.from(
      list.expand((element) => List.generate(times, (i) => element)),
    );
  }

  static final Map<String, List<Map<String, dynamic>>> beverageMenu = {
    '콜드 브루': _repeat([
      {'name': '나이트로 콜드 브루', 'price': '6,000', 'en': 'Nitro Cold Brew'},
      {'name': '돌체 콜드 브루', 'price': '6,000', 'en': 'Dolce Cold Brew'},
      {'name': '콜드 브루', 'price': '4,900', 'en': 'Cold Brew'},
      {'name': '바닐라 크림 콜드 브루', 'price': '5,800', 'en': 'Vanilla Cream Cold Brew'},
      {'name': '오트 콜드 브루', 'price': '5,800', 'en': 'Oat Cold Brew'},
      {'name': '제주 비자림 콜드 브루', 'price': '6,800', 'en': 'Jeju Forest Cold Brew'},
    ], 10),
    '에스프레소': _repeat([
      {'name': '아메리카노', 'price': '4,500', 'en': 'Caffe Americano'},
      {'name': '카페 라떼', 'price': '5,000', 'en': 'Caffe Latte'},
      {'name': '카푸치노', 'price': '5,000', 'en': 'Cappuccino'},
      {'name': '카라멜 마키아또', 'price': '5,900', 'en': 'Caramel Macchiato'},
      {'name': '스타벅스 돌체 라떼', 'price': '5,900', 'en': 'Starbucks Dolce Latte'},
    ], 10),
    '프라푸치노': _repeat([
      {'name': '자바 칩 프라푸치노', 'price': '6,300', 'en': 'Java Chip Frappuccino'},
      {'name': '카라멜 프라푸치노', 'price': '5,900', 'en': 'Caramel Frappuccino'},
      {'name': '제주 말차 크림 프라푸치노', 'price': '6,300', 'en': 'Jeju Matcha Cream Frappuccino'},
    ], 10),
    '블렌디드': _repeat([
      {'name': '망고 바나나 블렌디드', 'price': '6,300', 'en': 'Mango Banana Blended'},
      {'name': '딸기 딜라이트 요거트 블렌디드', 'price': '6,300', 'en': 'Strawberry Delight Yogurt Blended'},
    ], 10),
    '티 (Tea)': _repeat([
      {'name': '자몽 허니 블랙 티', 'price': '5,700', 'en': 'Grapefruit Honey Black Tea'},
      {'name': '유자 민트 티', 'price': '5,900', 'en': 'Yuaja Mint Tea'},
      {'name': '차이 티 라떼', 'price': '5,500', 'en': 'Chai Tea Latte'},
    ], 10),
  };

  static final Map<String, List<Map<String, dynamic>>> foodMenu = {
    '케이크': _repeat([
      {'name': '부드러운 생크림 카스텔라', 'price': '4,500', 'en': 'Fresh Cream Castella'},
      {'name': '클라우드 치즈 케이크', 'price': '5,500', 'en': 'Cloud Cheese Cake'},
      {'name': '7 레이어 가나슈 케이크', 'price': '5,700', 'en': '7 Layer Ganache Cake'},
    ], 10),
    '샌드위치 & 샐러드': _repeat([
      {'name': 'B.E.L.T. 샌드위치', 'price': '5,900', 'en': 'B.E.L.T. Sandwich'},
      {'name': '에그 에그 샌드위치', 'price': '4,400', 'en': 'Egg Egg Sandwich'},
      {'name': '바비큐 치킨 치즈 치아바타', 'price': '5,800', 'en': 'BBQ Chicken Cheese Ciabatta'},
    ], 10),
    '브레드': _repeat([
      {'name': '하트 파이', 'price': '3,200', 'en': 'Heart Pie'},
      {'name': '미니 클래식 스콘', 'price': '4,000', 'en': 'Mini Classic Scone'},
      {'name': '베이글 (플레인/블루베리)', 'price': '3,000', 'en': 'Bagel'},
    ], 10),
  };

  static final Map<String, List<Map<String, dynamic>>> goodsMenu = {
    '머그 & 글라스': _repeat([
      {'name': '그린 사이렌 클래식 머그', 'price': '16,000', 'en': 'Green Siren Classic Mug'},
      {'name': 'SS 블랙 데비 머그', 'price': '22,000', 'en': 'SS Black Debbie Mug'},
      {'name': '더블월 글라스', 'price': '18,000', 'en': 'Double Wall Glass'},
    ], 10),
    '텀블러 & 보온병': _repeat([
      {'name': 'SS 엘마 블랙 텀블러', 'price': '33,000', 'en': 'SS Elma Black Tumbler'},
      {'name': 'JNL 제트 블랙 보온병', 'price': '48,000', 'en': 'JNL Jet Black Thermos'},
      {'name': '미르 텀블러', 'price': '35,000', 'en': 'MiiR Tumbler'},
    ], 10),
    '커피 용품': _repeat([
      {'name': '세라믹 드리퍼', 'price': '24,000', 'en': 'Ceramic Dripper'},
      {'name': '커피 프레스', 'price': '38,000', 'en': 'Coffee Press'},
    ], 10),
  };
}
