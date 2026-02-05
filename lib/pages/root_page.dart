import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/common/liquid_glass_nav_bar/liquid_glass_nav_bar.dart';
import '../widgets/common/space_background.dart';
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
  double _payViewDragOffset = 0.0;
  bool _isDraggingPayView = false;
  bool _isNavBarVisible = true;

  final List<Map<String, dynamic>> _navItems = [
    {'label': 'Home', 'icon': Icons.house_rounded},
    {'label': 'Pay', 'icon': Icons.wallet_rounded},
    {'label': 'Order', 'icon': Icons.shopping_bag_rounded},
    {'label': 'Shop', 'icon': Icons.storefront_rounded},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  void _onItemTapped(int index) {
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
  }

  @override
  Widget build(BuildContext context) {
    final isPaySelected = _selectedIndex == 1;

    // Calculate scale and opacity based on drag offset
    final screenHeight = MediaQuery.of(context).size.height;
    final dismissThreshold = screenHeight * 0.25;
    final dragRatio = (_payViewDragOffset / dismissThreshold).clamp(0.0, 1.0);
    final scaleValue = 0.92 + (0.08 * dragRatio); // Scale from 0.92 to 1.0
    final opacityValue = 0.8 + (0.2 * dragRatio); // Opacity from 0.8 to 1.0

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black, // Fallback color
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (_isNavBarVisible) setState(() => _isNavBarVisible = false);
          } else if (notification.direction == ScrollDirection.forward) {
            if (!_isNavBarVisible) setState(() => _isNavBarVisible = true);
          }
          return true;
        },
        child: Stack(
          children: [
            // Space Background
            if (isPaySelected)
              const Positioned.fill(
                child: SpaceBackground(),
              ),
  
            // Main Body (Background)
            AnimatedContainer(
              duration: _isDraggingPayView
                  ? Duration.zero
                  : const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // Use alignment to keep it centered when scaling
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..scale(isPaySelected ? scaleValue : 1.0),
              transformAlignment: Alignment.center, // Scale from center
              decoration: BoxDecoration(
                borderRadius:
                    isPaySelected ? BorderRadius.circular(20) : BorderRadius.zero,
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Opacity(
                opacity: isPaySelected ? opacityValue : 1.0,
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
  
            // Glass Navbar (Floating above content, below PayView)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: LiquidGlassNavBar(
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
                items: _navItems,
                isVisible: _isNavBarVisible && !isPaySelected, // Hide when Pay is active
              ),
            ),
  
            // Pay View (Overlay)
            AnimatedPositioned(
              duration: _isDraggingPayView
                  ? Duration.zero
                  : const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              top: isPaySelected
                  ? 120 + _payViewDragOffset
                  : MediaQuery.of(context).size.height,
              left: isPaySelected ? 16 : 0,
              right: isPaySelected ? 16 : 0,
              bottom: isPaySelected
                  ? -_payViewDragOffset
                  : 120 - MediaQuery.of(context).size.height,
              child: IgnorePointer(
                ignoring: !isPaySelected && !_isDraggingPayView,
                child: GestureDetector(
                  onVerticalDragStart: (details) {
                  if (isPaySelected) {
                    setState(() {
                      _isDraggingPayView = true;
                    });
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (isPaySelected && _isDraggingPayView) {
                    setState(() {
                      // Follow user's finger but prevent moving above original position
                      final newOffset = _payViewDragOffset + details.delta.dy;
                      _payViewDragOffset = newOffset.clamp(
                          0.0, MediaQuery.of(context).size.height);
                    });
                  }
                },
                onVerticalDragEnd: (details) {
                  if (isPaySelected && _isDraggingPayView) {
                    setState(() {
                      _isDraggingPayView = false;
  
                      final screenHeight = MediaQuery.of(context).size.height;
                      final dismissThreshold = screenHeight * 0.25;
                      final isVelocityEnough = details.primaryVelocity! > 600;
  
                      if (_payViewDragOffset > dismissThreshold ||
                          isVelocityEnough) {
                        // Close
                        _selectedIndex = _previousIndex;
                        _payViewDragOffset = 0.0;
                      } else {
                        // Snap back
                        _payViewDragOffset = 0.0;
                      }
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: _isDraggingPayView
                      ? Duration.zero
                      : const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
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
                  child: Column(
                    children: [
                      // Drag Handle
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12, bottom: 4),
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      const Expanded(child: PayView()),
                    ],
                  ),
                ),
              ),
              ),
            ),
          ],
        ),
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

