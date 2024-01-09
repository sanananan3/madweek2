import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<Tab2> {
  final _random = Random();

  List<String> videoIds = [
    'D8VEhcPeSlc',
    '97_-_WugRFA',
    'iUw3LPM7OBU',
    'WGm2HmXeeRI',
    'gvXsmI3Gdq8',
    '5_n6t9G2TUQ',
    '3kGAlp_PNUg',
    '9JFi7MmjtGA',
    'yFlxYHjHYAw',
    'j1uXcHwLhHM',
    'KHouJsSH4PM',
    'EIz09kLzN9k',
    '6ZUIwj3FgUY',
    'jOTfBlKSQYY',
    'eQNHDV7lKgE',
    'Dbxzh078jr4',
    'ArmDp-zijuc',
    'sVTy_wmn5SU',
    'UNo0TG9LwwI',
  ];

  String currentVideoId = 'D8VEhcPeSlc';

  final _con = YoutubePlayerController(
    initialVideoId: 'D8VEhcPeSlc',
    flags: const YoutubePlayerFlags(startAt: 59),
  );

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    setState(() {
      final newVideoId = videoIds[_random.nextInt(videoIds.length)];
      _con.load(newVideoId);
      currentVideoId = newVideoId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '검색',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SearchAnchor(
                builder: (context, controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onTap: () => controller.openView(),
                    onChanged: (_) => controller.openView(),
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder: (context, controller) {
                  return List<ListTile>.generate(
                    5,
                    (index) => ListTile(title: Text('item $index')),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '   지금 가장 핫한 국내 음악을 감상하세요! ',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            YoutubePlayer(controller: _con),
            const SizedBox(height: 16),
            const Text(
              '   나를 위한 실시간 트렌드',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
