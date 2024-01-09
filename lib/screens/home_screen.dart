import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';

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
          Text('2'),
          Text('3'),
          Text('4'),
          Text('5'),
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
            icon: Icon(Icons.abc),
            label: 'Tap 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 4',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 5',
          ),
        ],
      ),
    );
  }
}
