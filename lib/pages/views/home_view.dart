import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

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
                delegate: _HomeHeaderDelegate(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final int itemIndex = index + 1;

                  if (itemIndex == 1) {
                    return SizedBox(
                      height: 200,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              dragDevices: {
                                PointerDeviceKind.touch,
                                PointerDeviceKind.mouse,
                              },
                            ),
                            child: PageView.builder(
                              padEnds: false,
                              controller: PageController(
                                viewportFraction: 416 / constraints.maxWidth,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, horizontalIndex) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  color: Colors.accents[
                                      horizontalIndex % Colors.accents.length],
                                  child: Center(
                                    child: Text(
                                      'H-Item $horizontalIndex',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // 각 아이템마다 랜덤한 높이 생성 (100 ~ 300)
                  return Container(
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.primaries[itemIndex % Colors.primaries.length],
                    child: Center(
                      child: Text(
                        'Item $itemIndex',
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  );
                },
                childCount: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // 상단 영역 (Top)
          Positioned(
            bottom: 50, // 하단 메뉴 높이만큼 위로
            left: 0,
            right: 0,
            height: 150,
            child: Container(
              color: Colors.primaries[0],
              child: Center(
                child: Text(
                  'Header Top',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
          // 하단 영역 (Bottom) - 메뉴
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 50,
            child: SizedBox(
              height: 50,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, subIndex) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.all(8.0),
                      color: Colors.accents[subIndex % Colors.accents.length],
                      child: Center(
                        child: Text(
                          'Header Menu $subIndex',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 150 + 50; // 최대 보여질 높이 (상단 영역 + 하단 영역)

  @override
  double get minExtent => 50; // 최소 보여질 높이 (하단 영역 높이만 남김)

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
