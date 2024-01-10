import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';
import 'package:madcamp_week2/screens/recommend_screen.dart';
import 'package:madcamp_week2/screens/search_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).value!;
    final currentIndex = useState(0);
    final screens = useRef([
      const RecommendScreen(),
      const SearchScreen(),
      ProfileScreen(user: user),
    ]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            visualDensity: VisualDensity.standard,
            onPressed: () async {
              if (await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text('로그아웃하시겠습니까?'),
                      contentPadding: const EdgeInsets.all(24),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('아니오'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('네'),
                        ),
                      ],
                    ),
                  ) ??
                  false) {
                await ref.read(userNotifierProvider.notifier).logout();
              }
            },
          ),
        ],
      ),
      body: screens.value.elementAt(currentIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '메인',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
