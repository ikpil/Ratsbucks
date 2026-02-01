import 'package:flutter/material.dart';

class OrderProductTile extends StatefulWidget {
  final Map<String, dynamic> item;

  const OrderProductTile({
    super.key,
    required this.item,
  });

  @override
  State<OrderProductTile> createState() => _OrderProductTileState();
}

class _OrderProductTileState extends State<OrderProductTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: Row(
            children: [
              // 3. Product Image (Embossed Circle)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5F5F5),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-2, -2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color(0xFFE0E0E0),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.coffee,
                    size: 40,
                    color: Colors.brown.shade300,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // Text Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1. Product Name
                    Text(
                      widget.item['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // 2. Product English Name
                    Text(
                      widget.item['en'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9E9E9E),
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // 4. Product Price
                    Text(
                      '${widget.item['price']}원',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
