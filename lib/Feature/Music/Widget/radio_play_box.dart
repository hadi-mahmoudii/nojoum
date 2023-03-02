// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/loading.dart';

class AudioManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
  final String url;
  late AudioPlayer _audioPlayer;
  AudioManager(this.url) {
    _init();
  }
  void _init() async {
    // print('object');
    try {
      _audioPlayer = AudioPlayer();
      await _audioPlayer.setUrl(url);
      _audioPlayer.playerStateStream.listen((playerState) {
        final isPlaying = playerState.playing;
        final processingState = playerState.processingState;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          buttonNotifier.value = ButtonState.loading;
        } else if (!isPlaying) {
          buttonNotifier.value = ButtonState.paused;
        } else {
          buttonNotifier.value = ButtonState.playing;
        }
      });
      _audioPlayer.positionStream.listen((position) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: position,
          buffered: oldState.buffered,
          total: oldState.total,
        );
      });
      _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: bufferedPosition,
          total: oldState.total,
        );
      });
      _audioPlayer.durationStream.listen((totalDuration) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: totalDuration ?? Duration.zero,
        );
      });
      play();
    } catch (e) {}
  }

  void play() {
    _audioPlayer.play();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void pause() {
    _audioPlayer.pause();
  }

  void dispose() {
    try {
      _audioPlayer.dispose();
    } catch (e) {}
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }

class RadioUiBox extends StatefulWidget {
  final String url;
  final Color? color;
  const RadioUiBox({
    Key? key,
    required this.url,
    required this.color,
  }) : super(key: key);

  @override
  _RadioUiBoxState createState() => _RadioUiBoxState();
}

class _RadioUiBoxState extends State<RadioUiBox> {
  late AudioManager _audioManager;

  @override
  void initState() {
    super.initState();
    _audioManager = AudioManager(widget.url);
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      // width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ValueListenableBuilder<ProgressBarState>(
          //   valueListenable: _audioManager.progressNotifier,
          //   builder: (_, value, __) {
          //     return ProgressBar(
          //       progress: value.current,
          //       buffered: value.buffered,
          //       total: value.total,
          //       onSeek: _audioManager.seek,
          //       thumbColor: widget.color,
          //       progressBarColor: widget.color!.withOpacity(.9),
          //       baseBarColor: widget.color!.withOpacity(.25),
          //       bufferedBarColor: widget.color!.withOpacity(.25),
          //     );
          //   },
          // ),
          const Center(
            child: Text(
              'LIVE',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ValueListenableBuilder<ProgressBarState>(
              //   valueListenable: _audioManager.progressNotifier,
              //   builder: (_, value, __) {
              //     return IconButton(
              //       icon: Icon(
              //         FlutterIcons.fast_bw,
              //         color: widget.color,
              //         size: 25,
              //       ),
              //       iconSize: 25.0,
              //       onPressed: () => _audioManager
              //           .seek(value.current - const Duration(seconds: 10)),
              //     );
              //   },
              // ),
              const SizedBox(width: 5),
              ValueListenableBuilder<ButtonState>(
                valueListenable: _audioManager.buttonNotifier,
                builder: (_, value, __) {
                  switch (value) {
                    case ButtonState.loading:
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        width: 35.0,
                        height: 35.0,
                        child: const LoadingWidget(),
                      );
                    case ButtonState.paused:
                      return IconButton(
                        icon: Icon(
                          FlutterIcons.play_1,
                          color: widget.color,
                          size: 35,
                        ),
                        // iconSize: 32.0,
                        onPressed: () => _audioManager.play(),
                      );
                    case ButtonState.playing:
                      return IconButton(
                        icon: Icon(
                          FlutterIcons.pause,
                          color: widget.color,
                          size: 35,
                        ),
                        // iconSize: 32.0,
                        onPressed: () => _audioManager.pause(),
                      );
                    default:
                      return Container();
                  }
                },
              ),
              // const SizedBox(width: 5),
              // ValueListenableBuilder<ProgressBarState>(
              //   valueListenable: _audioManager.progressNotifier,
              //   builder: (_, value, __) {
              //     return IconButton(
              //       icon: Icon(
              //         FlutterIcons.fast_fw,
              //         color: widget.color,
              //         size: 25,
              //       ),
              //       iconSize: 25.0,
              //       onPressed: () => _audioManager
              //           .seek(value.current + const Duration(seconds: 10)),
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
