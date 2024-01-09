import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/tweet_write_screen.dart';
import 'package:madcamp_week2/widgets/tweet_block.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider).value!;

    final formattedDate =
        DateFormat('yyyy년 MM월 dd일에 가입함').format(user.createdAt.toLocal());
    final formmatedBirth =
        DateFormat('yyyy년 MM월 dd일에 태어난').format(user.birthDate.toLocal());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (cnotext) => const TweetWriteScreen(),
              ),
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formmatedBirth,
                    style: const TextStyle(
                      color: Color.fromARGB(137, 34, 34, 34),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
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
                              const SizedBox(width: 4),
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
                  switch (ref.watch(myTweetsNotifierProvider)) {
                    AsyncData(:final value) when value != null =>
                      RefreshIndicator(
                        onRefresh: () => ref
                            .read(myTweetsNotifierProvider.notifier)
                            .refresh(),
                        child: ListView.separated(
                          itemCount: value.length,
                          itemBuilder: (context, index) =>
                              _buildTweetBlock(context, ref, value[index]),
                          separatorBuilder: (context, index) => const Divider(),
                        ),
                      ),
                    AsyncLoading() => ListView.separated(
                        itemCount: 5,
                        itemBuilder: (context, index) => const TweetBlock(),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    _ => const SizedBox.shrink(),
                  },
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
    );
  }

  Widget _buildTweetBlock(BuildContext context, WidgetRef ref, Tweet tweet) {
    return TweetBlock(
      tweet: tweet,
      onEditPressed: () async {
        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (cnotext) => TweetWriteScreen(tweet: tweet),
          ),
        );
      },
      onDeletePressed: () async {
        if (await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text('삭제하시겠습니까?'),
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
          await ref
              .read(myTweetsNotifierProvider.notifier)
              .deleteTweet(tweet.id);
        }
      },
    );
  }
}
