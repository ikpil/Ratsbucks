class Event {
  final String title;
  final String date;
  final String imagePath;
  final String content;

  const Event({
    required this.title,
    required this.date,
    required this.imagePath,
    required this.content,
  });
}

class EventGroup {
  final String title;
  final String description;
  final List<Event> events;

  const EventGroup({
    required this.title,
    required this.description,
    required this.events,
  });
}

final List<EventGroup> homeEvents = [
  EventGroup(
    title: "What's New",
    description: "새로 나온 메뉴와 소식을 만나보세요",
    events: [
      Event(
        title: '딸기 라떼의 계절이 돌아왔어요!',
        date: '2024.01.01 - 2024.02.28',
        imagePath: 'assets/images/events/strawberry_latte.jpg',
        content:
            "봄의 전령사, 딸기가 돌아왔습니다!\n\n상큼하고 달콤한 국내산 설향 딸기가 듬뿍 들어간 '리얼 스트로베리 라떼'를 만나보세요.\n\n매일 아침 매장에서 직접 손질한 신선한 딸기를 사용하여 더욱 풍부한 과육을 즐기실 수 있습니다.\n\n함께 출시된 '스트로베리 치즈 타르트'와 함께라면 더욱 완벽한 딸기 파티가 될 거예요.\n\n지금 바로 가까운 래츠벅스 매장에서 봄을 미리 느껴보세요!",
      ),
      Event(
        title: '설날 맞이 기프트 카드 출시',
        date: '2024.01.15 - 2024.02.10',
        imagePath: 'assets/images/events/gift_card.jpg',
        content:
            "2024년 갑진년 새해, 소중한 분들에게 마음을 전해보세요.\n\n푸른 용의 기운을 담은 한정판 '2024 뉴이어 기프트 카드'가 출시되었습니다.\n\n전통 문양을 모던하게 재해석한 디자인으로 소장 가치까지 더했습니다.\n\n기프트 카드는 1만원부터 50만원까지 원하시는 금액으로 충전이 가능하며,\n래츠벅스 앱에 등록하여 편리하게 사용하실 수 있습니다.\n\n새해 복 많이 받으시고, 따뜻한 마음을 나누는 명절 되세요.",
      ),
    ],
  ),
  EventGroup(
    title: "Coupon & Benefit",
    description: "놓치지 말아야 할 혜택",
    events: [
      Event(
        title: '사이렌 오더 주문 시 별 3개 적립',
        date: '2024.01.20 - 2024.01.31',
        imagePath: 'assets/images/events/siren_order.jpg',
        content:
            "바쁜 아침, 줄 서지 말고 사이렌 오더로 주문하세요!\n\n이벤트 기간 동안 래츠벅스 앱의 사이렌 오더를 이용하여\n제조 음료를 주문하시면, 음료 한 잔당 별 3개를 추가로 적립해 드립니다.\n\n(병음료, 요거트 등 완제품 제외)\n\n적립된 별은 12개가 모이면 무료 음료 쿠폰으로 발행됩니다.\n\n편리함과 혜택, 두 마리 토끼를 모두 잡을 수 있는 기회를 놓치지 마세요!",
      ),
      Event(
        title: '텀블러 사용 시 에코별 추가 적립',
        date: '상시 혜택',
        imagePath: 'assets/images/events/tumbler.jpg',
        content:
            "지구를 위한 작은 실천, 래츠벅스가 함께 응원합니다.\n\n개인 텀블러나 다회용 컵을 이용하여 제조 음료를 주문하시면,\n300원 할인 또는 에코별 1개 적립 혜택을 드립니다.\n\n(래츠벅스 리워드 회원은 계정 설정에서 혜택을 선택하실 수 있습니다.)\n\n일회용 컵 없는 매장 만들기, 여러분의 동참이 큰 힘이 됩니다.\n환경을 생각하는 당신이 진정한 래츠벅스의 VIP입니다.",
      ),
    ],
  ),
  EventGroup(
    title: "Recommendation",
    description: "회원님을 위한 특별한 추천",
    events: [
      Event(
        title: '비오는 날엔 따뜻한 아메리카노',
        date: '오늘의 추천',
        imagePath: 'assets/images/events/americano.jpg',
        content:
            "추적추적 비가 내리는 오늘,\n따뜻한 아메리카노 한 잔 어떠신가요?\n\n래츠벅스의 시그니처 블렌드로 내린 아메리카노는\n깊고 진한 풍미와 깔끔한 뒷맛이 일품입니다.\n\n창밖의 빗소리를 들으며 즐기는 커피 한 잔의 여유.\n\n오늘 하루, 래츠벅스에서 감성 충전하세요.\n따뜻한 스콘과 함께 곁들이면 더욱 좋습니다.",
      ),
    ],
  ),
];
