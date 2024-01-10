import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class YtMusicNotifier extends Notifier<String> {
  final _random = Random();
  final _videoIds = [
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

  @override
  String build() => _videoIds[_random.nextInt(_videoIds.length)];

  void refresh() => state = build();
}

final ytMusicNotifierProvider =
    NotifierProvider<YtMusicNotifier, String>(YtMusicNotifier.new);
