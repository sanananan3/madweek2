import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/models/tweet.dart';
import 'package:madcamp_week2/providers/rest_client.dart';
import 'package:madcamp_week2/rest_client.dart';

class MyTweetsNotifier extends AsyncNotifier<List<Tweet>?> {
  @override
  FutureOr<List<Tweet>?> build() async {
    try {
      final restClient = ref.watch(restClientProvider);
      final response = await restClient.getMyTweets();
      if (response.success) {
        return response.tweets;
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  Future<void> refresh() async => state = AsyncData(await build());

  Future<String?> writeTweet(String content) async {
    try {
      final restClient = ref.read(restClientProvider);
      final response =
          await restClient.writeTweet(TweetRequestBody(content: content));
      if (response.success) {
        state = AsyncData([response.tweets!.first, ...?state.value]);
        return null;
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<String?> editTweet(int id, String content) async {
    try {
      final restClient = ref.read(restClientProvider);
      final response = await restClient
          .editTweet(TweetRequestBody(id: id, content: content));
      if (response.success) {
        state = AsyncData([
          for (final tweet in state.value!)
            if (tweet.id == id) tweet.copyWith(content: content) else tweet,
        ]);
        return null;
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }

  Future<String?> deleteTweet(int id) async {
    try {
      final restClient = ref.read(restClientProvider);
      final response = await restClient.deleteTweet(TweetRequestBody(id: id));
      if (response.success) {
        state =
            AsyncData(state.value!.where((tweet) => tweet.id != id).toList());
        return null;
      }
    } on DioException catch (error) {
      return error.message;
    }
    return '알 수 없는 오류가 발생했습니다.';
  }
}

final tweetsProvider = FutureProvider.autoDispose((ref) async {
  final restClient = ref.watch(restClientProvider);
  final response = await restClient.getTweets();
  if (response.success) {
    return response.tweets;
  }
  return null;
});

final myTweetsNotifierProvider =
    AsyncNotifierProvider<MyTweetsNotifier, List<Tweet>?>(MyTweetsNotifier.new);
