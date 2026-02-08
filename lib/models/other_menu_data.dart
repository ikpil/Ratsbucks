import 'package:flutter/material.dart';
import '../models/other_menu_item.dart';

final List<OtherMenuSection> otherMenuData = [
  OtherMenuSection(
    title: '서비스',
    items: [
      OtherMenuItem(
        icon: Icons.star_border_rounded,
        title: '리워드 및 혜택',
        page: _createPlaceholderPage('리워드 및 혜택'),
      ),
      OtherMenuItem(
        icon: Icons.card_giftcard_rounded,
        title: '기프트 카드',
        page: _createPlaceholderPage('기프트 카드'),
      ),
      OtherMenuItem(
        icon: Icons.receipt_long_rounded,
        title: '전자 영수증',
        page: _createPlaceholderPage('전자 영수증'),
      ),
      OtherMenuItem(
        icon: Icons.history_rounded,
        title: '주문 히스토리',
        page: _createPlaceholderPage('주문 히스토리'),
      ),
    ],
  ),
  OtherMenuSection(
    title: '고객 지원',
    items: [
      OtherMenuItem(
        icon: Icons.help_outline_rounded,
        title: '고객센터',
        page: _createPlaceholderPage('고객센터'),
      ),
      OtherMenuItem(
        icon: Icons.notifications_none_rounded,
        title: '공지사항',
        page: _createPlaceholderPage('공지사항'),
      ),
      OtherMenuItem(
        icon: Icons.store_mall_directory_outlined,
        title: '매장 정보',
        page: _createPlaceholderPage('매장 정보'),
      ),
    ],
  ),
  OtherMenuSection(
    title: '앱 설정',
    items: [
      OtherMenuItem(
        icon: Icons.lock_outline_rounded,
        title: '개인정보 관리',
        page: _createPlaceholderPage('개인정보 관리'),
      ),
      OtherMenuItem(
        icon: Icons.info_outline_rounded,
        title: '버전 정보',
        trailing: 'v1.0.0',
        page: _createPlaceholderPage('버전 정보'),
      ),
      OtherMenuItem(
        icon: Icons.logout_rounded,
        title: '로그아웃',
        isDestructive: true,
        // No page for logout, maybe a dialog? Or just print for now.
      ),
    ],
  ),
];

Widget _createPlaceholderPage(String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('$title 페이지입니다.')),
  );
}
