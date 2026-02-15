import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order_product.dart';
import '../../models/order_payment_item.dart';
import '../../pages/payment/payment_page.dart';
import 'product_detail/product_option_section.dart';
import 'product_detail/product_temperature_section.dart';

class ProductOrderModal extends StatefulWidget {
  final OrderProduct item;
  final bool initialIsIce;
  final String initialSelectedBean;

  const ProductOrderModal({
    super.key,
    required this.item,
    required this.initialIsIce,
    required this.initialSelectedBean,
  });

  @override
  State<ProductOrderModal> createState() => _ProductOrderModalState();
}

class _ProductOrderModalState extends State<ProductOrderModal> {
  late bool isIce;
  late String selectedBean;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    isIce = widget.initialIsIce;
    selectedBean = widget.initialSelectedBean;
  }

  int get price => widget.item.priceInt;

  int get totalPrice => price * quantity;

  String get formattedTotalPrice {
    return NumberFormat('#,###').format(totalPrice);
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 핸들바
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // 상품명
          Text(
            widget.item.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // 옵션 선택 (Hot/Ice)
          ProductTemperatureSection(
            isIce: isIce,
            onToggle: (val) => setState(() => isIce = val),
          ),
          const SizedBox(height: 24),

          // 옵션 선택 (원두)
          ProductOptionSection(
            selectedBean: selectedBean,
            onBeanSelected: (val) => setState(() => selectedBean = val),
          ),
          const SizedBox(height: 32),

          // 수량 및 가격
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 수량 조절
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove),
                      color: quantity > 1 ? Colors.black : Colors.grey,
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),

              // 총 가격
              Text(
                '$formattedTotalPrice원',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 주문하기 버튼
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // 모달 닫기
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    items: [
                      OrderPaymentItem(
                        name: widget.item.name,
                        unitPrice: price,
                        quantity: quantity,
                        isIce: isIce,
                        selectedBean: selectedBean,
                      ),
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00704A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              '주문하기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
