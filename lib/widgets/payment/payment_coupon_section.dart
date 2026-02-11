import 'package:flutter/material.dart';

class PaymentCouponSection extends StatelessWidget {
  final int couponDiscount;
  final int voucherDiscount;
  final VoidCallback onSelectCoupon;
  final VoidCallback onSelectVoucher;

  const PaymentCouponSection({
    super.key,
    required this.couponDiscount,
    required this.voucherDiscount,
    required this.onSelectCoupon,
    required this.onSelectVoucher,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '쿠폰 및 할인',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildDiscountRow(
          '쿠폰',
          couponDiscount,
          onSelectCoupon,
        ),
        const SizedBox(height: 12),
        _buildDiscountRow(
          '모바일 상품권',
          voucherDiscount,
          onSelectVoucher,
        ),
      ],
    );
  }

  Widget _buildDiscountRow(String title, int discountAmount, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (discountAmount > 0)
              Text(
                '-${discountAmount}원',
                style: const TextStyle(
                  color: Color(0xFF00704A),
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              const Text(
                '사용 안 함',
                style: TextStyle(color: Colors.grey),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
