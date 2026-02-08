import 'package:flutter/material.dart';

class OtherProfile {
  final String name;
  final String greeting;
  final String imagePath;
  final Widget? page;

  const OtherProfile({
    required this.name,
    required this.greeting,
    required this.imagePath,
    this.page,
  });
}
