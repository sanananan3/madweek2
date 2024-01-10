import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final isCardFlipped = useState(false);

    useRef(
      Timer.periodic(const Duration(seconds:0), (timer) {
        isCardFlipped.value = !isCardFlipped.value;
      }),
    );

    ref.listen(
      ytMusicNotifierProvider,
      (prev, next) => youtubePlayerController.load(next),
    );

    useEffect(() {
      if (isCardFlipped.value) {
        Future.delayed(const Duration(seconds: 5), () {
          isCardFlipped.value = !isCardFlipped.value;
        });
      }
    }, [isCardFlipped.value]);
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
          const SizedBox(height: 20),
          const Text(
            '    대한민국에서 트렌드 중',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: isCardFlipped.value
                ? SizedBox(
                    height: 30,
                    width: 400,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi * 180), // Flip the card
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Adjust the color as needed
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            '    과자파티',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 30,
                    width: 400,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Adjust the color as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '    제주항공',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          const Text(
            '    Only on X 실시간 트렌드',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: isCardFlipped.value
                ? SizedBox(
                    height: 30,
                    width: 400,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi * 180), // Flip the card
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Adjust the color as needed
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            '    솔로지옥',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 30,
                    width: 400,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Adjust the color as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '    환승연애',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          const Text(
            '    대한민국에서 트렌드 중',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: isCardFlipped.value
                ? SizedBox(
              height: 30,
              width: 400,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi * 180), // Flip the card
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue, // Adjust the color as needed
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      '    대설주의보',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
                : SizedBox(
              height: 30,
              width: 400,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // Adjust the color as needed
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    '    잇츠라이브',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '    대한민국에서 트렌드 중',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: isCardFlipped.value
                ? SizedBox(
                    height: 30,
                    width: 400,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi * 180), // Flip the card
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Adjust the color as needed
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            '    누나 잠들면 안대',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 30,
                    width: 400,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Adjust the color as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '    #LALISA',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          const Text(
            '    패션, 뷰티 실시간 트렌드',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds:1000),
            child: isCardFlipped.value
                ? SizedBox(
                    height: 30,
                    width: 400,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi * 180), // Flip the card
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Adjust the color as needed
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            '    쌍계피지떡',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 30,
                    width: 400,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue, // Adjust the color as needed
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '    좌석 추첨',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
