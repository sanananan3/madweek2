import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:shimmer/shimmer.dart';

class TweetBlock extends StatelessWidget {
  final Tweet? tweet;
  final VoidCallback? onPressed;
  final VoidCallback? onLikePressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const TweetBlock({
    this.tweet,
    this.onPressed,
    this.onLikePressed,
    this.onEditPressed,
    this.onDeletePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (tweet?.user != null) const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (tweet == null)
                  Shimmer.fromColors(
                    baseColor: Colors.blueGrey.shade700,
                    highlightColor: Colors.blueGrey.shade900,
                    child: Container(
                      width: 100,
                      height: 16,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                    ),
                  )
                else ...[
                  if (tweet!.user != null) ...[
                    Text(
                      tweet!.user!.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      ' @ ${tweet!.user!.userId ?? tweet!.user!.kakaoId}',
                    ),
                    const Spacer(),
                  ],
                  const Text('• '),
                  _buildDateText(tweet!.createdAt.toLocal()),
                  if (tweet!.user == null)
                    PopupMenuButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.more_vert,
                          size: 16,
                        ),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem<void>(
                          onTap: onEditPressed,
                          child: const ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('수정'),
                          ),
                        ),
                        PopupMenuItem<void>(
                          onTap: onDeletePressed,
                          child: const ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('삭제'),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox(width: 8),
                ],
              ],
            ),
            if (tweet == null)
              ...List.generate(
                2,
                (_) => Shimmer.fromColors(
                  baseColor: Colors.blueGrey.shade700,
                  highlightColor: Colors.blueGrey.shade900,
                  child: Container(
                    height: 14,
                    margin: const EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else ...[
              const SizedBox(height: 8),
              Text(
                tweet!.content,
                style: const TextStyle(fontSize: 15),
              ),
            ],
            if (tweet?.user != null && tweet?.like != null)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onLikePressed,
                  icon: tweet!.like!
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline),
                  iconSize: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateText(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    late String formattedDate;

    if (difference.inMinutes < 1) {
      formattedDate = '방금 전';
    } else if (difference.inHours < 1) {
      formattedDate = '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      formattedDate = '${difference.inHours}시간 전';
    } else {
      formattedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
    }

    return Text(
      formattedDate,
      style: const TextStyle(fontSize: 14),
    );
  }
}
