import 'package:flutter/material.dart';

class TweetWriteScreen extends StatelessWidget {
  const TweetWriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    maxLines: 5,
                    decoration: InputDecoration(
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
                    onPressed: () {},
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
