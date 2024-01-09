import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/tweet.dart';

class TweetBlock extends StatelessWidget {
  final Tweet tweet;

  const TweetBlock({required this.tweet, super.key});

  @override
  Widget build(BuildContext context) {
    final difference = DateTime.now().difference(tweet.createdAt.toLocal());

    late String formattedDate;

    if (difference.inMinutes < 1) {
      formattedDate = '방금 전';
    } else if (difference.inHours < 1) {
      formattedDate = '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      formattedDate = '${difference.inHours}시간 전';
    } else {
      formattedDate =
          DateFormat('yyyy년 MM월 dd일').format(tweet.createdAt.toLocal());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              Text(formattedDate),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          Text(tweet.content),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
