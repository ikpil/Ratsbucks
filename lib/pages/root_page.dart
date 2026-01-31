import 'package:flutter/material.dart';
import '../widgets/glass_navbar.dart';
import 'views/home_view.dart';
import 'views/pay_view.dart';
import 'views/order_view.dart';
import 'views/shop_view.dart';
import 'views/other_view.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {'label': 'Home', 'icon': Icons.house_rounded},
    {'label': 'Pay', 'icon': Icons.wallet_rounded},
    {'label': 'Order', 'icon': Icons.shopping_bag_rounded},
    {'label': 'Shop', 'icon': Icons.storefront_rounded},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final isPaySelected = _selectedIndex == 1;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black, // Background color for the gap
      body: Stack(
        children: [
          // Main Body (Background)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // Use alignment to keep it centered when scaling
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(isPaySelected ? 0.92 : 1.0)
              ..translate(0.0, isPaySelected ? -20.0 : 0.0), // Slightly move up
            transformAlignment: Alignment.center, // Scale from center
            decoration: BoxDecoration(
              borderRadius:
                  isPaySelected ? BorderRadius.circular(20) : BorderRadius.zero,
              color: Colors.white,
            ),
            clipBehavior: Clip.hardEdge,
            child: Opacity(
              opacity: isPaySelected ? 0.8 : 1.0,
              child: IgnorePointer(
                ignoring: isPaySelected,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.amber.shade50,
                        Colors.orange.shade100,
                      ],
                    ),
                  ),
                  child: _getViewForIndex(
                      _selectedIndex == 1 ? _previousIndex : _selectedIndex),
                ),
              ),
            ),
          ),

          // Pay View (Overlay)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            top: isPaySelected ? 60 : MediaQuery.of(context).size.height,
            bottom: 0,
            left: isPaySelected ? 16 : 0, // Add side margins when visible
            right: isPaySelected ? 16 : 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: const PayView(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlassNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            if (_selectedIndex != 1 && index == 1) {
              _previousIndex = _selectedIndex;
            } else if (_selectedIndex == 1 && index != 1) {
              // Returning from Pay
            } else if (index != 1) {
              _previousIndex = index;
            }
            _selectedIndex = index;
          });
        },
        items: _navItems,
      ),
    );
  }

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const PayView(); // Not used in main body logic but kept for safety
      case 2:
        return const OrderView();
      case 3:
        return const ShopView();
      case 4:
        return const OtherView();
      default:
        return const HomeView();
    }
  }
}
