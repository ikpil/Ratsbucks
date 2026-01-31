import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/quick_order_section.dart';
import '../../widgets/home_event_section.dart';
import '../../widgets/home_header_delegate.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverSafeArea(
              bottom: false,
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: HomeHeaderDelegate(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final int itemIndex = index + 1;

                  if (itemIndex == 1) {
                    // 퀵 오더 영역
                    return const QuickOrderSection();
                  }

                  if (itemIndex == 2) {
                    // 이벤트 영역
                    return const HomeEventSection();
                  }

                  return const SizedBox.shrink();
                },
                childCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
// ...existing code...
  }
}
