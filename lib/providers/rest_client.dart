import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:madcamp_week2/providers/user.dart';
import 'package:madcamp_week2/rest_client.dart';

final restClientProvider = Provider(
  (ref) {
    final token = ref.watch(userNotifierProvider.select((e) => e.value?.token));
    return RestClient(
      Dio(
        BaseOptions(
          headers: {
            if (token != null && token.isNotEmpty) 'Authorization': token,
          },
        ),
      ),
    );
  },
);
