import 'package:flutter/material.dart';
import '../../models/event.dart';
import 'home_event_detail_page.dart';
import 'home_event_group_title.dart';
import 'home_event_card.dart';

class HomeEventSection extends StatelessWidget {
  const HomeEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          homeEvents.map((group) => _buildEventGroup(context, group)).toList(),
    );
  }

  Widget _buildEventGroup(BuildContext context, EventGroup group) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeEventGroupTitle(
            title: group.title,
            description: group.description,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: group.events.map((event) {
                return HomeEventCard(
                  event: event,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeEventDetailPage(event: event),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
