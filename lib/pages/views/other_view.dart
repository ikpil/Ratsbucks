import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../widgets/other/other_profile_header.dart';
import '../../widgets/other/other_menu_section.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        title: const Text(
          'Other',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            const OtherProfileHeader(),
            const SizedBox(height: 20),
            OtherMenuSection(
              title: '서비스',
              items: [
                OtherMenuItem(
                  icon: Icons.star_border_rounded,
                  title: '리워드 및 혜택',
                ),
                OtherMenuItem(
                  icon: Icons.card_giftcard_rounded,
                  title: '기프트 카드',
                ),
                OtherMenuItem(
                  icon: Icons.receipt_long_rounded,
                  title: '전자 영수증',
                ),
                OtherMenuItem(icon: Icons.history_rounded, title: '주문 히스토리'),
              ],
            ),
            const SizedBox(height: 20),
            OtherMenuSection(
              title: '고객 지원',
              items: [
                OtherMenuItem(icon: Icons.help_outline_rounded, title: '고객센터'),
                OtherMenuItem(
                  icon: Icons.notifications_none_rounded,
                  title: '공지사항',
                ),
                OtherMenuItem(
                  icon: Icons.store_mall_directory_outlined,
                  title: '매장 정보',
                ),
              ],
            ),
            const SizedBox(height: 20),
            OtherMenuSection(
              title: '앱 설정',
              items: [
                OtherMenuItem(
                  icon: Icons.lock_outline_rounded,
                  title: '개인정보 관리',
                ),
                OtherMenuItem(
                  icon: Icons.info_outline_rounded,
                  title: '버전 정보',
                  trailing: 'v1.0.0',
                ),
                OtherMenuItem(
                  icon: Icons.logout_rounded,
                  title: '로그아웃',
                  isDestructive: true,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
