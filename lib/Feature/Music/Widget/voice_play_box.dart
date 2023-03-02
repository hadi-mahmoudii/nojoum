import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/loading.dart';
import '../Model/playling_type.dart';
import '../Controllers/details.dart';

// class AudioManager {
//   final progressNotifier = ValueNotifier<ProgressBarState>(
//     ProgressBarState(
//       current: Duration.zero,
//       buffered: Duration.zero,
//       total: Duration.zero,
//     ),
//   );
//   final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
//   final MusicDetailsProvider provider;
//   final BuildContext mainCtx;
//   AudioManager(this.provider, this.mainCtx) {
//     _init();
//   }
//   void _init() async {
//     // print('object');
//     try {
//       // audioPlayer = AudioPlayer();
//       // await audioPlayer.setUrl(provider.music.link);
//       provider.audioPlayer.playerStateStream.listen((playerState) {
//         final isPlaying = playerState.playing;
//         final processingState = playerState.processingState;
//         if (processingState == ProcessingState.loading ||
//             processingState == ProcessingState.buffering) {
//           buttonNotifier.value = ButtonState.loading;
//         } else if (processingState == ProcessingState.completed) {
//           if (provider.letRepeat) {
//             provider.seek(const Duration(seconds: 0));
//             provider.audioPlayer.play();
//           } else if (provider.nextMusics.isNotEmpty) {
//             if (provider.letShuffle) {
//               provider.nextMusics.shuffle();
//             }
//             Navigator.of(mainCtx).pushReplacementNamed(
//               Routes.musicDetails,
//               arguments: provider.nextMusics[0].id,
//               // arguments: video.id,
//             );
//           } else {
//             provider.seek(const Duration(seconds: 0));
//             provider.audioPlayer.stop();
//           }
//           // print('object');
//         } else if (!isPlaying) {
//           buttonNotifier.value = ButtonState.paused;
//         } else {
//           buttonNotifier.value = ButtonState.playing;
//         }
//       });
//       provider.audioPlayer.positionStream.listen((position) {
//         final oldState = progressNotifier.value;
//         progressNotifier.value = ProgressBarState(
//           current: position,
//           buffered: oldState.buffered,
//           total: oldState.total,
//         );
//       });
//       provider.audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
//         final oldState = progressNotifier.value;
//         progressNotifier.value = ProgressBarState(
//           current: oldState.current,
//           buffered: bufferedPosition,
//           total: oldState.total,
//         );
//       });
//       provider.audioPlayer.durationStream.listen((totalDuration) {
//         final oldState = progressNotifier.value;
//         progressNotifier.value = ProgressBarState(
//           current: oldState.current,
//           buffered: oldState.buffered,
//           total: totalDuration ?? Duration.zero,
//         );
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error to play this music!');
//       // Navigator.of(mainCtx).pop();
//     }
//   }

//   // void play() {
//   //   provider.audioPlayer.play();
//   //   provider.changeHasValue(true);
//   // }

//   // void seek(Duration position) {
//   //   provider.audioPlayer.seek(position);
//   // }

//   // void pause() {
//   //   provider.audioPlayer.pause();
//   // }

//   // void dispose() {
//   //   try {
//   //     provider.audioPlayer.dispose();
//   //   } catch (e) {}
//   // }
// }

// enum ButtonState { paused, playing, loading }

class AudioUiBox extends StatefulWidget {
  // final MusicDetailsProvider provider;
  final BuildContext mainCtx;
  const AudioUiBox({
    Key? key,
    // required this.provider,
    required this.mainCtx,
  }) : super(key: key);

  @override
  _AudioUiBoxState createState() => _AudioUiBoxState();
}

class _AudioUiBoxState extends State<AudioUiBox> {
  // late AudioManager _audioManager;

  @override
  void initState() {
    super.initState();
    // _audioManager = AudioManager(widget.mainCtx);
  }

  // @override
  // void dispose() {
  //   _audioManager.dispose();
  //   super.dispose();
  // }
  final musicProvider = Get.find<MusicDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      late Widget mainButton;

      try {
        switch (musicProvider.buttonState.value) {
          case ButtonState.loading:
            mainButton = const SizedBox(
              height: 35,
              width: 35,
              child: LoadingWidget(),
            );
            break;
          case ButtonState.idle:
            mainButton = Container();
            break;
          case ButtonState.paused:
            mainButton = IconButton(
              icon: const Icon(
                FlutterIcons.play_1,
                color: mainFontColor,
                size: 35,
              ),
              // iconSize: 32.0,
              onPressed: () => musicProvider.play(),
            );
            break;
          case ButtonState.playing:
            mainButton = IconButton(
              icon: const Icon(
                FlutterIcons.pause,
                color: mainFontColor,
                size: 35,
              ),
              // iconSize: 32.0,
              onPressed: () => musicProvider.pause(),
            );
            break;
          default:
            mainButton = Container();
        }
      } catch (e) {
        mainButton = Container();
      }
      return musicProvider.typeIsMusic.value
          ? Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              // width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProgressBar(
                    progress: musicProvider.progressState.value.current,
                    buffered: musicProvider.progressState.value.buffered,
                    total: musicProvider.progressState.value.total,
                    onSeek: musicProvider.seek,
                    thumbColor: mainFontColor,
                    progressBarColor: mainFontColor.withOpacity(.9),
                    baseBarColor: mainFontColor.withOpacity(.25),
                    bufferedBarColor: mainFontColor.withOpacity(.25),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          FlutterIcons.arrows_cw,
                          color: musicProvider.letRepeat.value
                              ? mainFontColor
                              : mainFontColor.withOpacity(.5),
                          size: 25,
                        ),
                        iconSize: 25.0,
                        onPressed: () => musicProvider.changeletRepeat(),
                      ),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.fast_bw,
                          color: mainFontColor.withOpacity(
                              musicProvider.letPreviousMusic.value ? 1 : 0),
                          size: 25,
                        ),
                        iconSize: 25.0,
                        onPressed: () => musicProvider.letPreviousMusic.value
                            ? musicProvider.getPreviousMusic()
                            : null,
                      ),
                      const SizedBox(width: 5),
                      mainButton,
                      const SizedBox(width: 5),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.fast_fw,
                          color: mainFontColor.withOpacity(
                            musicProvider.letNextMusic.value ? 1 : 0,
                          ),
                          size: 25,
                        ),
                        iconSize: 25.0,
                        onPressed: () => musicProvider.letNextMusic.value
                            ? musicProvider.getNextMusic()
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          FlutterIcons.shuffle,
                          color: musicProvider.letShuffle.value
                              ? mainFontColor
                              : mainFontColor.withOpacity(.5),
                          size: 25,
                        ),
                        iconSize: 25.0,
                        onPressed: () => musicProvider.changeletShuffle(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : mainButton;
    });
  }
}
