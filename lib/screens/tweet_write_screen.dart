import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/providers/tweet.dart';
import 'package:madcamp_week2/providers/user.dart';

class TweetWriteScreen extends HookConsumerWidget {
  final Tweet? tweet;

  const TweetWriteScreen({this.tweet, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = useState<String?>(null);
    final contentController = useTextEditingController(text: tweet?.content);
    final userId = ref.watch(userNotifierProvider.select((e) => e.value!.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tweet != null ? '트윗 수정' : '새 트윗',
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: const Color(0xFF36465D),
      ),
      backgroundColor: const Color(0xFF273347),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(16),
            color: const Color(0xFFE3F2FD),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      errorText: errorText.value,
                      hintText: '무슨 일이 일어나고 있나요?',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF42A5F5),
                    ),
                    onPressed: () async {
                      final result = switch (tweet) {
                        Tweet(:final id) => await ref
                            .read(tweetsNotifierProvider(userId).notifier)
                            .editTweet(id, contentController.text),
                        _ => await ref
                            .read(tweetsNotifierProvider(userId).notifier)
                            .writeTweet(contentController.text),
                      };

                      if (!context.mounted) return;

                      if (result == null) {
                        errorText.value = null;
                        Navigator.pop(context);
                        return;
                      }

                      errorText.value = result;
                    },
                    child:
                        tweet != null ? const Text('수정하기') : const Text('게시하기'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
