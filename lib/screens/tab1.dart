import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user_data.dart';

class Tab1 extends StatelessWidget {
  final UserData user;

  const Tab1({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.userId ?? 'N/A',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            user.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            user.call,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            user.birth,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            '${user.date.toLocal()}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
