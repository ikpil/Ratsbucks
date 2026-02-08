import 'package:flutter/material.dart';

class OtherProfileHeader extends StatelessWidget {
  const OtherProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: const AssetImage(
              'assets/images/profile_placeholder.png',
            ), // Placeholder
            child: const Icon(Icons.person, size: 30, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ratsbucks 회원님',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '오늘도 즐거운 하루 되세요!',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
