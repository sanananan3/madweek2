import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';

final _currentIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_currentIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          ProfileScreen(),
          Text('2'),
          Text('3'),
          Text('4'),
          Text('5'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) =>
            ref.read(_currentIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'Tap 1',
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
