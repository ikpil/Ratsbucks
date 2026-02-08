import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/home/quick_order_section.dart';
import '../../widgets/home/home_event_section.dart';
import '../../widgets/home/home_header_delegate.dart';

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
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverSafeArea(
              bottom: false,
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: HomeHeaderDelegate(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                // 퀵 오더 영역
                const QuickOrderSection(),
                // 이벤트 영역
                const HomeEventSection(),
              ]),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
    // ...existing code...
  }
}
