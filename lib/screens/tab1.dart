import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user_data.dart';

class Tab1 extends StatelessWidget{

  final UserData user;

  Tab1({required this.user});

  @override
  Widget build(BuildContext context){

    return Container(
      padding: const EdgeInsets.all(16),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text('${user.userId ?? 'N/A'}',style: TextStyle(fontSize:18)),SizedBox(height:8),
          Text('${user.name}',style: TextStyle(fontSize: 18)), SizedBox(height: 8),
          Text('${user.call}',style: TextStyle(fontSize:18)), SizedBox(height:8),
          Text('${user.birth}', style:TextStyle(fontSize:18)), SizedBox(height:8),
          Text('${user.date.toLocal()}',style: TextStyle(fontSize:18)), SizedBox(height:8)
        ],
      ),
    );
  }
}
