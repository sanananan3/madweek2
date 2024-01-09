import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class _YoutubePlayerControllerHookCreator {
  const _YoutubePlayerControllerHookCreator();

  YoutubePlayerController call({
    required String initialVideoId,
    YoutubePlayerFlags flags = const YoutubePlayerFlags(),
  }) =>
      use(
        _YoutubePlayerControllerHook(
          initialVideoId: initialVideoId,
          flags: flags,
        ),
      );
}

const useYoutubePlayerController = _YoutubePlayerControllerHookCreator();

class _YoutubePlayerControllerHook extends Hook<YoutubePlayerController> {
  final String initialVideoId;
  final YoutubePlayerFlags flags;

  const _YoutubePlayerControllerHook({
    required this.initialVideoId,
    this.flags = const YoutubePlayerFlags(),
  });

  @override
  HookState<YoutubePlayerController, Hook<YoutubePlayerController>>
      createState() => _YoutubePlayerControllerHookState();
}

class _YoutubePlayerControllerHookState
    extends HookState<YoutubePlayerController, _YoutubePlayerControllerHook> {
  late final _controller = YoutubePlayerController(
    initialVideoId: hook.initialVideoId,
    flags: hook.flags,
  );

  @override
  YoutubePlayerController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  String get debugLabel => 'useYoutubePlayerController';
}
