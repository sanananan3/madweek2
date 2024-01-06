import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user_data.dart';
import 'package:intl/intl.dart';



class Tab1 extends StatelessWidget {
  final UserData user;

  const Tab1({required this.user, super.key});


  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy년 mm월 dd일').format(user.date.toLocal());

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(
            height: 100
            color:const Color(0xFF2B2B2B),

           Text(
            user.userId ?? 'N/A',
            style: const TextStyle(fontSize: 18),
          ),


          const SizedBox(height: 8)),
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
            '$formattedDate',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
