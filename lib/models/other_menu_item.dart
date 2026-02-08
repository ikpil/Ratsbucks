import 'package:flutter/material.dart';

class OtherMenuItem {
  final IconData icon;
  final String title;
  final String? trailing;
  final bool isDestructive;
  final Widget? page;

  const OtherMenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.isDestructive = false,
    this.page,
  });
}

class OtherMenuSection {
  final String title;
  final List<OtherMenuItem> items;

  const OtherMenuSection({required this.title, required this.items});
}
