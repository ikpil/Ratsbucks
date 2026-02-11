import 'package:flutter/material.dart';

class PaymentMethodSection extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String> onMethodSelected;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '결제 수단',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildPaymentOption('스타벅스 카드 (기본)', 'STARBUCKS_CARD'),
              const Divider(height: 1),
              _buildPaymentOption('신용카드', 'CREDIT_CARD'),
              const Divider(height: 1),
              _buildPaymentOption('간편결제', 'EASY_PAY'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(String title, String value) {
    final isSelected = selectedMethod == value;
    return InkWell(
      onTap: () => onMethodSelected(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF00704A) : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
