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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index == 1) {
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
              color: Colors.primaries[index % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $index',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
