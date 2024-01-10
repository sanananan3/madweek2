import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/screens/tweet_write_screen.dart';
import 'package:madcamp_week2/widgets/tweet_block.dart';
import 'package:madcamp_week2/widgets/tweet_list_view.dart';

class ProfileScreen extends ConsumerWidget {
  final User user;

  const ProfileScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(userNotifierProvider.select((e) => e.value!.id));

    final formattedDate =
        DateFormat('yyyy년 MM월 dd일에 가입함').format(user.createdAt.toLocal());
    final formmatedBirth =
        DateFormat('yyyy년 MM월 dd일에 태어난').format(user.birthDate.toLocal());

    return DefaultTabController(
      length: 2,
      child: Column(
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
                const SizedBox(height: 4),
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
                  ],
                ),
                const SizedBox(height: 16),
                /*
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
                ),*/
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
              Tab(text: '마음에 들어요'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TweetListView(
                  asyncValue: ref.watch(tweetsNotifierProvider(user.id)),
                  onRefresh: () => ref
                      .read(tweetsNotifierProvider(user.id).notifier)
                      .refresh(),
                  builder: (context, tweet) =>
                      _buildTweetBlock(context, ref, tweet, user.id, myId),
                ),
                TweetListView(
                  asyncValue: ref.watch(tweetsNotifierProvider(-user.id)),
                  onRefresh: () => ref
                      .read(tweetsNotifierProvider(-user.id).notifier)
                      .refresh(),
                  builder: (context, tweet) =>
                      _buildTweetBlock(context, ref, tweet, -user.id, myId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TweetBlock _buildTweetBlock(
    BuildContext context,
    WidgetRef ref,
    Tweet tweet,
    int userId,
    int myId,
  ) {
    return TweetBlock(
      tweet: tweet.userId != myId ? tweet.copyWith(user: user) : tweet,
      onLikePressed: () async {
        if (tweet.like!) {
          await ref
              .read(tweetsNotifierProvider(userId).notifier)
              .cancelLikeTweet(tweet.id);
        } else {
          await ref
              .read(tweetsNotifierProvider(userId).notifier)
              .doLikeTweet(tweet.id);
        }
      },
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
              .read(tweetsNotifierProvider(userId).notifier)
              .deleteTweet(tweet.id);
        }
      },
    );
  }
}
