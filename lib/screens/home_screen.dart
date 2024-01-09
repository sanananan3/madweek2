import 'package:flutter/material.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';
import 'package:madcamp_week2/screens/tab2.dart';
import 'package:flutter_hooks/flutter_hooks.dart';



class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      body: IndexedStack(

        index: currentIndex.value,
        children: const [
          ProfileScreen(),
          Tab2(),
          Text('3'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => currentIndex.value = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: '추천 게시물',
          ),


        ],
      ),
    );
  }
}
