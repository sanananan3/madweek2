import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/widgets/tweet_block.dart';

class TweetListView extends StatelessWidget {
  final AsyncValue<List<Tweet>?> asyncValue;
  final RefreshCallback onRefresh;
  final TweetBlock? Function(BuildContext, Tweet) builder;

  const TweetListView({
    required this.asyncValue,
    required this.onRefresh,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return switch (asyncValue) {
      AsyncData(:final value) when value != null => RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) => builder(context, value[index]),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      _ => ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) => const TweetBlock(),
          separatorBuilder: (context, index) => const Divider(),
        ),
    };
  }
}
