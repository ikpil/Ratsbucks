import 'package:flutter/material.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.more_horiz_rounded,
            color: Colors.blue.shade400,
            size: 100,
          ),
          const SizedBox(height: 24),
          Text(
            'Other',
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Additional features and settings',
            style: TextStyle(
              color: Colors.blue.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
