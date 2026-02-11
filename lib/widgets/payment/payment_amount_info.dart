import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentAmountInfo extends StatelessWidget {
  final int totalOrderPrice;
  final int discountCoupon;
  final int discountVoucher;

  const PaymentAmountInfo({
    super.key,
    required this.totalOrderPrice,
    required this.discountCoupon,
    required this.discountVoucher,
  });

  int get finalPrice {
    int total = totalOrderPrice - discountCoupon - discountVoucher;
    return total < 0 ? 0 : total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '결제 금액',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPriceRow('총 주문 금액', totalOrderPrice),
              const SizedBox(height: 12),
              if (discountCoupon > 0)
                _buildPriceRow('쿠폰 할인', -discountCoupon, isDiscount: true),
              const SizedBox(height: 8),
              if (discountVoucher > 0)
                _buildPriceRow('모바일 상품권', -discountVoucher, isDiscount: true),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '최종 결제 금액',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${NumberFormat('#,###').format(finalPrice)}원',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00704A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String title, int amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          '${NumberFormat('#,###').format(amount)}원',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDiscount ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }
}
