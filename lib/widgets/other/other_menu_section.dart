import 'package:flutter/material.dart';
import '../../models/other_menu_item.dart';

class OtherMenuSectionWidget extends StatelessWidget {
  final OtherMenuSection section;

  const OtherMenuSectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            section.title,
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
            children: section.items.map((item) {
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
                    onTap: () {
                      if (item.page != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => item.page!),
                        );
                      }
                    },
                  ),
                  if (section.items.last != item)
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
