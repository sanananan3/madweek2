import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';
import 'package:madcamp_week2/screens/tweet_write_screen.dart';
import 'package:madcamp_week2/widgets/tweet_block.dart';
import 'package:madcamp_week2/widgets/tweet_list_view.dart';

class RecommendScreen extends ConsumerWidget {
  const RecommendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
      body: TweetListView(
        asyncValue: ref.watch(tweetsNotifierProvider(0)),
        onRefresh: () => ref.read(tweetsNotifierProvider(0).notifier).refresh(),
        builder: (context, tweet) => TweetBlock(
          tweet: tweet,
          isMy: false,
          onPressed: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                  body: ProfileScreen(user: tweet.user!),
                ),
              ),
            );
          },
          onLikePressed: () async {
            if (tweet.like!) {
              await ref
                  .read(tweetsNotifierProvider(0).notifier)
                  .cancelLikeTweet(tweet.id);
            } else {
              await ref
                  .read(tweetsNotifierProvider(0).notifier)
                  .doLikeTweet(tweet.id);
            }
          },
        ),
      ),
    );
  }
}
