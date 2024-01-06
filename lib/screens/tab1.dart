import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user_data.dart';
import 'package:intl/intl.dart';



class Tab1 extends StatelessWidget {
  final UserData user;

  const Tab1({required this.user, super.key});

  Widget build(BuildContext context) {

    String formattedDate = DateFormat('yyyy년 mm월 dd일').format(user.date.toLocal());


    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                       user.birth,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        user.userId != null? user.userId! : user.kakaoId!,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 28,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                '$formattedDate',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1B33B),
                  ),
                    child: Text('팔로워',
                      style: TextStyle(  color: Colors.black,),

                    ),

                  ),
                  TextButton(
                    onPressed: (){

                    },style: TextButton.styleFrom(backgroundColor: Color(0xFF1F2123),
                  ),
                    child: Text('팔로잉', style: TextStyle(color: Colors.white,
                    ),
                    ),
                  ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
