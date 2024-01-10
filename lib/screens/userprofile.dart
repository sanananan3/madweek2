import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:madcamp_week2/models/user.dart';

class UserProfilePage extends StatelessWidget {
  final User user;

  const UserProfilePage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('yyyy년 MM월 dd일에 가입함').format(user.createdAt.toLocal());
    final formattedBirth =
        DateFormat('yyyy년 MM월 dd일에 가입함').format(user.birthDate.toLocal());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${user.name}의 페이지',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedBirth,
                style: const TextStyle(
                  color: Colors.white54,
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
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),
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
                  Tab(text: '미디어'),
                  Tab(text: '마음에 들어요'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    // TODO: Add content for '게시물' tab
                    Center(child: Text('게시물 내용')),
                    // TODO: Add content for '미디어' tab
                    Center(child: Text('미디어 내용')),
                    // TODO: Add content for '마음에 들어요' tab
                    Center(child: Text('마음에 들어요 내용')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
