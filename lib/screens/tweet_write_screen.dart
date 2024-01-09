import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/tweet.dart';

class TweetWriteScreen extends HookConsumerWidget {
  const TweetWriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = useState<String?>(null);
    final contentController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '새 트윗',
          style: TextStyle(fontSize: 18),
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
                      final result = await ref
                          .read(myTweetsNotifierProvider.notifier)
                          .writeTweet(contentController.text);

                      if (!context.mounted) return;

                      if (result == null) {
                        errorText.value = null;
                        Navigator.pop(context);
                        return;
                      }

                      errorText.value = result;
                    },
                    child: const Text('게시하기'),
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
