import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../widgets/other/other_profile_header.dart';
import '../../widgets/other/other_menu_section.dart';
import '../../models/other_menu_data.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    // Nav bar height (70) + margin (34) + extra buffer
    final bottomPadding = 120.0 + MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Other',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: EdgeInsets.only(bottom: bottomPadding),
          children: [
            OtherProfileHeader(profile: otherProfileData),
            const SizedBox(height: 20),
            ...otherMenuData.map((section) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: OtherMenuSectionWidget(section: section),
              );
            }),
          ],
        ),
      ),
    );
  }
}
