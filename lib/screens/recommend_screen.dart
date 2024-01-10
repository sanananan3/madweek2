import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/widgets/tweet_block.dart';

class RecommendScreen extends ConsumerWidget {
  const RecommendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: switch (ref.watch(tweetsProvider)) {
        AsyncData(:final value) when value != null => ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) => TweetBlock(
              tweet: value[index].tweet,
              user: value[index].user,
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        _ => ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) => const TweetBlock(),
            separatorBuilder: (context, index) => const Divider(),
          ),
      },
    );
  }
}
