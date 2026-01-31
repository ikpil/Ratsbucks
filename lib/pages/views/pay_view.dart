import 'package:flutter/material.dart';
import 'dart:ui';
import '../../widgets/pay_card_carousel.dart';
import '../../widgets/pay_method_list.dart';

class PayView extends StatelessWidget {
  const PayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
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
            // Custom App Bar
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              centerTitle: false, // 좌측 정렬 명시
              backgroundColor: const Color(0xFFF9F9F9),
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                title: const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(color: const Color(0xFFF9F9F9)),
              ),
            ),

            // Registered Cards Carousel
            const SliverToBoxAdapter(
              child: PayCardCarousel(),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Add New Method Section
            const SliverToBoxAdapter(
              child: PayMethodList(),
            ),
          ],
        ),
      ),
    );
  }
}
