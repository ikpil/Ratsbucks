import 'package:flutter/material.dart';
import '../../models/other_profile.dart';

class OtherProfileHeader extends StatelessWidget {
  final OtherProfile profile;

  const OtherProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (profile.page != null) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => profile.page!));
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(profile.imagePath),
              child: const Icon(Icons.person, size: 30, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.greeting,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
