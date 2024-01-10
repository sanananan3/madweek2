import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/hooks/youtube_player_controller.dart';
import 'package:madcamp_week2/providers/rest_client.dart';
import 'package:madcamp_week2/providers/yt_music.dart';
import 'package:madcamp_week2/screens/profile_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final youtubePlayerController = useYoutubePlayerController(
      initialVideoId: ref.read(ytMusicNotifierProvider),
      flags: const YoutubePlayerFlags(mute: true, startAt: 59),
    );

    ref.listen(
      ytMusicNotifierProvider,
      (prev, next) => youtubePlayerController.load(next),
    );

    return RefreshIndicator(
      onRefresh: () async =>
          ref.read(ytMusicNotifierProvider.notifier).refresh(),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SearchAnchor(
              builder: (context, controller) {
                return TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: const Color(0xFF3A393C),
                    hintText: '검색...',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
                    ),
                  ),
                  onTap: () => controller.openView(),
                );
              },
              suggestionsBuilder: (context, controller) async {
                final search = controller.text;
                if (search.length < 2) return [];

                try {
                  final response = await ref
                      .read(restClientProvider)
                      .getUsers({'search': search});
                  if (response.success) {
                    return response.users!
                        .map(
                          (user) => ListTile(
                            title: Text(
                              '${user.name} @${user.userId ?? user.kakaoId}',
                            ),
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(),
                                    body: ProfileScreen(user: user),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList();
                  }
                } catch (error) {
                  return const [
                    ListTile(
                      title: Text('알 수 없는 오류가 발생했습니다.'),
                      textColor: Colors.red,
                    ),
                  ];
                }
                return [];
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
          YoutubePlayer(controller: youtubePlayerController),
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
    );
  }
}
