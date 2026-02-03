class Event {
  final String title;
  final String date;
  final String imagePath;

  const Event({
    required this.title,
    required this.date,
    required this.imagePath,
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
      ),
      Event(
        title: '설날 맞이 기프트 카드 출시',
        date: '2024.01.15 - 2024.02.10',
        imagePath: 'assets/images/events/gift_card.jpg',
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
      ),
      Event(
        title: '텀블러 사용 시 에코별 추가 적립',
        date: '상시 혜택',
        imagePath: 'assets/images/events/tumbler.jpg',
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
      ),
    ],
  ),
];
