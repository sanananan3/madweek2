import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/models/user.dart';
import 'package:shimmer/shimmer.dart';

class TweetBlock extends StatelessWidget {
  final Tweet? tweet;
  final User? user;
  final VoidCallback? onPressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;

  const TweetBlock({
    this.tweet,
    this.user,
    this.onPressed,
    this.onEditPressed,
    this.onDeletePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white,
                      ),
                    ),
                  )
                else ...[
                  if (user != null) ...[
                    Text(
                      user!.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      ' @ ${user!.userId ?? user!.kakaoId}',
                    ),
                    const Spacer(),
                  ],
                  const Text('• '),
                  _buildDateText(tweet!.createdAt.toLocal()),
                  if (user == null)
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
            if (user != null) const SizedBox(height: 8),
            if (tweet == null)
              ...List.generate(
                2,
                (_) => Shimmer.fromColors(
                  baseColor: Colors.blueGrey.shade700,
                  highlightColor: Colors.blueGrey.shade900,
                  child: Container(
                    height: 14,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              Text(
                tweet!.content,
                style: const TextStyle(fontSize: 15),
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
