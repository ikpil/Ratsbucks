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

  final List<Map<String, dynamic>> _navItems = [
    {'label': 'Home', 'icon': Icons.house_rounded},
    {'label': 'Pay', 'icon': Icons.wallet_rounded},
    {'label': 'Order', 'icon': Icons.shopping_bag_rounded},
    {'label': 'Shop', 'icon': Icons.storefront_rounded},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _buildBody(),
      bottomNavigationBar: GlassNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navItems,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
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
      child: _getViewForIndex(_selectedIndex),
    );
  }

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const PayView();
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
