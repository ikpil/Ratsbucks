import 'package:flutter/material.dart';

class OtherMenuItem {
  final IconData icon;
  final String title;
  final String? trailing;
  final bool isDestructive;

  OtherMenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.isDestructive = false,
  });
}

class OtherMenuSection extends StatelessWidget {
  final String title;
  final List<OtherMenuItem> items;

  const OtherMenuSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: items.map((item) {
              return Column(
                children: [
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: item.isDestructive
                          ? Colors.red
                          : Colors.grey.shade700,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        color: item.isDestructive ? Colors.red : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: item.trailing != null
                        ? Text(
                            item.trailing!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          )
                        : Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.grey.shade300,
                          ),
                    onTap: () {},
                  ),
                  if (items.last != item)
                    Divider(
                      height: 1,
                      indent: 56, // Icon width + padding
                      color: Colors.grey.shade100,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
