import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/rest_client.dart';

class MyTweetsNotifier extends AsyncNotifier<List<Tweet>?> {
  @override
  FutureOr<List<Tweet>?> build() async {
    try {
      final token =
          ref.watch(userNotifierProvider.select((e) => e.value?.token));
      if (token != null) {
        final response = await restClient.getMyTweets({'token': token});
        if (response.success) {
          return response.tweets;
        }
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<void> refresh() async => state = AsyncData(await build());

  Future<String?> writeTweet(String content) async {
    try {
      final token =
          ref.watch(userNotifierProvider.select((e) => e.value?.token));
      if (token != null) {
        final response = await restClient.writeTweet({
          'token': token,
          'content': content,
        });
        if (response.success) {
          state = AsyncData([response.tweets!.first, ...?state.value]);
          return null;
        }
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }
}

final tweetsProvider = FutureProvider.autoDispose((ref) async {
  final token = ref.watch(userNotifierProvider.select((e) => e.value?.token));
  if (token != null) {
    final response = await restClient.getTweets({'token': token});
    if (response.success) {
      return response.tweets;
    }
  }
  return null;
});

final myTweetsNotifierProvider =
    AsyncNotifierProvider<MyTweetsNotifier, List<Tweet>?>(MyTweetsNotifier.new);
