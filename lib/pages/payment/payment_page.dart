import 'package:flutter/material.dart';
import '../../models/order_payment_item.dart';
import '../../widgets/payment/payment_order_summary.dart';
import '../../widgets/payment/payment_coupon_section.dart';
import '../../widgets/payment/payment_method_section.dart';
import '../../widgets/payment/payment_amount_info.dart';

class PaymentPage extends StatefulWidget {
  final List<OrderPaymentItem> items;

  const PaymentPage({
    super.key,
    required this.items,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // 상태 관리 변수들
  String selectedMethod = 'STARBUCKS_CARD';
  int couponDiscount = 0;
  int voucherDiscount = 0;

  @override
  void initState() {
    super.initState();
  }

  // 총 주문 금액 계산
  int get totalOrderPrice {
    return widget.items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // 최종 결제 금액 계산
  int get finalPrice {
    int total = totalOrderPrice - couponDiscount - voucherDiscount;
    return total < 0 ? 0 : total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결제하기'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2. 주문 내역
            PaymentOrderSummary(items: widget.items),
            const SizedBox(height: 32),

            // 3. 쿠폰 및 할인
            PaymentCouponSection(
              couponDiscount: couponDiscount,
              voucherDiscount: voucherDiscount,
              onSelectCoupon: () {
                // 쿠폰 선택 모달 등을 띄우는 로직 (더미 데이터로 시뮬레이션)
                setState(() {
                  couponDiscount = (couponDiscount == 0) ? 1000 : 0;
                });
              },
              onSelectVoucher: () {
                // 모바일 상품권 선택 로직 (더미 데이터로 시뮬레이션)
                setState(() {
                  voucherDiscount = (voucherDiscount == 0) ? 5000 : 0;
                });
              },
            ),
            const SizedBox(height: 32),

            // 4. 결제 수단
            PaymentMethodSection(
              selectedMethod: selectedMethod,
              onMethodSelected: (val) {
                setState(() {
                  selectedMethod = val;
                });
              },
            ),
            const SizedBox(height: 32),

            // 5. 결제 금액 정보
            PaymentAmountInfo(
              totalOrderPrice: totalOrderPrice,
              discountCoupon: couponDiscount,
              discountVoucher: voucherDiscount,
            ),
            const SizedBox(height: 40),

            // 6. 결제하기 버튼
            ElevatedButton(
              onPressed: () {
                // 결제 프로세스 실행
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('결제 완료'),
                    content: Text('총 ${finalPrice}원이 결제되었습니다.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                          Navigator.of(context).pop(); // 결제 페이지 닫기
                          Navigator.of(context).pop(); // 모달 닫기 (필요시)
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00704A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                '결제하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
