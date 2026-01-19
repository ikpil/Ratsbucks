import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final IconData icon;

  NavItem({
    required this.label,
    required this.icon,
  });
}

final List<NavItem> navItems = [
  NavItem(label: 'Home', icon: Icons.house_rounded),
  NavItem(label: 'Pay', icon: Icons.wallet_rounded),
  NavItem(label: 'Order', icon: Icons.shopping_bag_rounded),
  NavItem(label: 'Shop', icon: Icons.storefront_rounded),
  NavItem(label: 'Other', icon: Icons.more_horiz_rounded),
];
