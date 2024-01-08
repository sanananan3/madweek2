import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/tweet_write_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).asData!.value!;

    final formattedDate =
        DateFormat('yyyy년 MM월 dd일에 가입함').format(user.createdAt.toLocal());
    final formmatedBirth =
        DateFormat('yyyy년 MM월 dd일에 태어난').format(user.birthDate.toLocal());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (cnotext) => const TweetWriteScreen(),
              ),
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formmatedBirth,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' @ ${user.userId ?? user.kakaoId}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 16,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('프로필 수정'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('팔로워'),
                      ),
                      const SizedBox(width: 32),
                      TextButton(
                        onPressed: () {},
                        child: const Text('팔로잉'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                tabs: [
                  Tab(text: '게시물'),
                  Tab(text: '미디어'),
                  Tab(text: '마음에 들어요'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: 1000,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              'TEST DATA $index',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      itemCount: 1000,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final number = <int>[
                          Random().nextInt(255),
                          Random().nextInt(255),
                          Random().nextInt(255),
                        ];
                        return ColoredBox(
                          color: Color.fromRGBO(
                            number[0],
                            number[1],
                            number[2],
                            1,
                          ),
                          child: Center(
                            child: Text(
                              'Grid View $index',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    GridView.builder(
                      itemCount: 1000,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final number = <int>[
                          Random().nextInt(255),
                          Random().nextInt(255),
                          Random().nextInt(255),
                        ];
                        return ColoredBox(
                          color: Color.fromRGBO(
                            number[0],
                            number[1],
                            number[2],
                            1,
                          ),
                          child: Center(
                            child: Text(
                              'Grid View $index',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
