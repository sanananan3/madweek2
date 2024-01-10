import 'package:flutter/material.dart';
import 'package:madcamp_week2/providers//user.dart'; // User 클래스가 정의된 경로에 맞게 수정해주세요.
import 'package:madcamp_week2/models/user.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({required this.user});

  _UserProfilePageState createState() => _UserProfilePageState();

}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy년 MM월 dd일에 가입함').format(widget.user.createdAt.toLocal());
    final formattedBirth = DateFormat('yyyy년 MM월 dd일에 태어난').format(widget.user.birthDate.toLocal());

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.user.name}의 페이지', style: TextStyle(fontSize: 18)),
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
              widget.user.name,
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
                      ' @ ${widget.user.userId ?? widget.user.kakaoId}',
                      style: TextStyle(
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
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
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
            TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: '게시물'),
                Tab(text: '미디어'),
                Tab(text: '마음에 들어요'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
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
    );
  }
}