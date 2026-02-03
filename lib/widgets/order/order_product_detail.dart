import 'package:flutter/material.dart';
import 'dart:ui';

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
          // 컨텐츠가 화면보다 짧아도 항상 스크롤(바운스) 가능하게 설정
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // 1. 상품 이미지 섹션 (SliverAppBar)
            SliverAppBar(
              expandedHeight: 450.0,
              pinned: true,
              stretch: true, // 바운스 시 이미지가 늘어나는 효과
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 20),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax, // 배경이 천천히 움직여 깊이감 제공
                stretchModes: const [
                  StretchMode.zoomBackground, // 바운스 시 이미지 확대 효과만 유지
                ],
                background: widget.item['image'] != null
                    ? Image.asset(
                        widget.item['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
                      )
                    : _buildPlaceholderImage(),
              ),
            ),

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
                        // 2. 상품에 대한 설명 섹션
                        Text(
                          widget.item['name'] ?? '상품 이름',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item['en'] ?? 'Product English Name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.item['description'] ??
                              '진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 32),

                  // 3. 가격 & 4. Hot/Ice 표기
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.item['price'] ?? 4500}원',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Hot/Ice Toggle
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            _buildTempOption('Hot', !isIce, Colors.redAccent),
                            _buildTempOption('Ice', isIce, Colors.blueAccent),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  Divider(color: Colors.grey[200], thickness: 1),
                  const SizedBox(height: 32),

                  // 5. 상품의 제일 중요한 옵션들 (원두)
                  const Text(
                    '퍼스널 옵션',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text('원두 선택',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildOptionChips(['블론드', '디카페인', '1/2디카페인']),

                  const SizedBox(height: 40),

                  // 6. 제품 영양 정보
                  const Text(
                    '제품 영양 정보',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildNutritionInfo(),

                  const SizedBox(height: 40),

                  // 7. 알레르기 유발 요인들
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0), // 연한 주황색 배경
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.orange[800], size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '알레르기 유발 요인',
                                style: TextStyle(
                                  color: Colors.orange[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '우유, 대두, 밀 포함 가능성 있음',
                                style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 8. 비슷한 다른 메뉴들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '이 메뉴와 비슷한 상품',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('전체보기',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSimilarProducts(),

                  const SizedBox(height: 80), // 하단 여백
                ],
              ),
            ),
          ),
          ),
          ),
          
          // 하단 여백 보정 (Transform으로 올라간 만큼)
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

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: Icon(Icons.coffee, size: 80, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildTempOption(String label, bool isSelected, Color activeColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isIce = label == 'Ice';
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[500],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionChips(List<String> options) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final isSelected = selectedBean == option;
        return InkWell(
          onTap: () {
            setState(() {
              selectedBean = option;
            });
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF00704A).withOpacity(0.05)
                  : Colors.white,
              border: Border.all(
                color: isSelected ? const Color(0xFF00704A) : Colors.grey[300]!,
                width: isSelected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? const Color(0xFF00704A) : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNutritionInfo() {
    final nutrients = [
      {'label': '칼로리', 'value': '10', 'unit': 'kcal'},
      {'label': '당류', 'value': '0', 'unit': 'g'},
      {'label': '나트륨', 'value': '5', 'unit': 'mg'},
      {'label': '단백질', 'value': '1', 'unit': 'g'},
      {'label': '카페인', 'value': '150', 'unit': 'mg'},
      {'label': '포화지방', 'value': '0', 'unit': 'g'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: nutrients.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nutrients[index]['label']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: nutrients[index]['value'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: ' ${nutrients[index]['unit']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSimilarProducts() {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                      image: widget.item['image'] != null
                          ? DecorationImage(
                              image: AssetImage(widget.item['image']),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: widget.item['image'] == null
                        ? Center(
                            child: Icon(Icons.coffee,
                                size: 40, color: Colors.grey[300]))
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.item['name'] ?? '추천 메뉴 ${index + 1}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.item['price'] ?? 4500}원',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
