import 'package:flutter/material.dart';
import 'dart:ui';

import 'product_detail/product_allergy_section.dart';
import 'product_detail/product_image_header.dart';
import 'product_detail/product_info_section.dart';
import 'product_detail/product_nutrition_section.dart';
import 'product_detail/product_option_section.dart';
import 'product_detail/product_price_section.dart';
import 'product_detail/product_temperature_section.dart';
import 'product_detail/similar_product_section.dart';

class ProductDetailView extends StatefulWidget {
  final Map<String, dynamic> item;

  const ProductDetailView({super.key, required this.item});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  // 상태 관리 변수들
  bool isIce = true; // 기본값 Ice
  String selectedBean = '블론드'; // 기본 선택 원두

  @override
  Widget build(BuildContext context) {
    // 테마 컬러 정의
    const primaryColor = Color(0xFF00704A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // 1. 상품 이미지 섹션
            ProductImageHeader(item: widget.item),

            // 컨텐츠 섹션
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -30), // 상단으로 30픽셀 이동하여 이미지와 겹침
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // 2. 상품 설명 섹션
                        ProductInfoSection(item: widget.item),

                        const SizedBox(height: 32),

                        // 3. 가격
                        ProductPriceSection(
                          price: widget.item['price'],
                        ),

                        const SizedBox(height: 24),

                        // 4. Hot/Ice 선택 (가격 아래 배치)
                        ProductTemperatureSection(
                          isIce: isIce,
                          onToggle: (val) => setState(() => isIce = val),
                        ),

                        const SizedBox(height: 32),
                        Divider(color: Colors.grey[200], thickness: 1),
                        const SizedBox(height: 32),

                        // 4. 옵션 선택
                        ProductOptionSection(
                          selectedBean: selectedBean,
                          onBeanSelected: (val) =>
                              setState(() => selectedBean = val),
                        ),

                        const SizedBox(height: 40),

                        // 5. 영양 정보
                        const ProductNutritionSection(),

                        const SizedBox(height: 40),

                        // 6. 알레르기 정보
                        const ProductAllergySection(),

                        const SizedBox(height: 40),

                        // 7. 비슷한 메뉴
                        SimilarProductSection(item: widget.item),

                        const SizedBox(height: 80), // 하단 여백
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // 하단 여백 보정
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.transparent)),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              '주문하기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
