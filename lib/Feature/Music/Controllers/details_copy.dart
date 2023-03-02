// ignore_for_file: invalid_use_of_protected_member

import 'package:audio_service/audio_service.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nojoum/Feature/General/Model/radio.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Model/music.dart';
import '../Model/playling_type.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  // final MediaItem _item;

  final AudioPlayer _player = AudioPlayer();

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    // mediaItem.add(_item);

    // // Load the player.
    // _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  // @override
  // Future<void> onNotificationDeleted() async => print('object');

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
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

class MusicDetailsController extends GetxController {
  var isLoading = true.obs;
  var isLoadingAddPlaylist = false.obs;
  var letShuffle = false.obs;
  var letRepeat = false.obs;
  var hasValue = false.obs;
  var progressState = ProgressBarState(
    current: const Duration(seconds: 0),
    buffered: const Duration(seconds: 0),
    total: const Duration(seconds: 0),
  ).obs;
  var buttonState = ButtonState.idle.obs;
  changeHasValue(bool value) {
    hasValue.value = value;
    //notifyListeners();
  }

  changeletShuffle() {
    letShuffle.value = !letShuffle.value;
    if (letShuffle.value) {
      letRepeat.value = false;
    }
    //notifyListeners();
  }

  changeletRepeat() {
    letRepeat.value = !letRepeat.value;
    if (letRepeat.value) {
      letShuffle.value = false;
    }
    //notifyListeners();
  }

  TextEditingController textCtrl = TextEditingController();
  TextEditingController playListCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  var currentPage = 1.obs;
  var lockPage = false.obs;
  // AudioPlayer audioPlayer = AudioPlayer();
  void play() async {
    // audioHandler.onNotificationDeleted()
    audioHandler.play();
    // audioPlayer.play();
    buttonState.value = ButtonState.playing;
    //notifyListeners();
    changeHasValue(true);
  }

  void seek(Duration position) {
    // late Duration pos;
    // try {
    //   if (position.inSeconds < 0) {
    //     pos = const Duration(seconds: 0);
    //   } else if (position.inSeconds > audioPlayer.duration!.inSeconds) {
    //     pos = audioPlayer.duration!;
    //   } else {
    //     pos = position;
    //   }
    // } catch (e) {
    //   pos = position;
    // }

    // audioPlayer.seek(pos);
  }

  void pause() {
    try {
      audioHandler.pause();
      buttonState.value = ButtonState.paused;
    } catch (_) {}

    //notifyListeners();
  }

  late AudioHandler audioHandler;
  late MusicModel music;
  late RadioModel radio;
  var isMyFavorite = false.obs;
  changeFavoriteValue() {
    isMyFavorite.value = !isMyFavorite.value;
  }

  getNextMusic() {
    fetchData(nextMusics.value[0].id, true);
  }

  getPreviousMusic() {
    fetchData(previousMusics.value[0].id, true);
  }

  var typeIsMusic = true.obs;
  var nextMusics = [].obs;
  var letNextMusic = true.obs;

  var previousMusics = [].obs;
  var letPreviousMusic = true.obs;

  // var playlists = [].obs;
  resetMusicDatas() async {
    try {
      hasValue.value = false;
    } catch (_) {}
    //notifyListeners();
    try {
      await audioHandler.stop();
    } catch (_) {}
    try {
      nextMusics.value = [];
      previousMusics.value = [];
      letNextMusic.value = true;
      letPreviousMusic.value = true;
      // playlists.value = [];
      isLoadingAddPlaylist.value = false;
      // letShuffle.value = false;
      // letRepeat.value = false;
      typeIsMusic.value = true;
      progressState.value = ProgressBarState(
        current: const Duration(seconds: 0),
        buffered: const Duration(seconds: 0),
        total: const Duration(seconds: 0),
      );
      buttonState.value = ButtonState.idle;
      //notifyListeners();
    } catch (_) {}
    try {
      // ignore: unnecessary_new
      // audioPlayer = new AudioPlayer();
    } catch (_) {}
  }

  fetchData(String musicId, bool typeIsMus, {RadioModel? rad}) async {
    if (musicId == '0') {
      isLoading.value = false;
      //notifyListeners();
      return;
    }
    try {
      if (musicId == music.id) {
        isLoading.value = false;
        //notifyListeners();
        return;
      }
    } catch (_) {}
    await resetMusicDatas();
    isLoading.value = true;
    //notifyListeners();
    if (typeIsMus) {
      Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
        Urls.getMusic(musicId),
      );
      res.fold(
        (error) async {
          // await ErrorResult.showDlg(error.type, context);
          isLoading.value = false;
          //notifyListeners();
        },
        (resultt) async {
          try {
            music = MusicModel.fromJson(resultt['data']);
            isMyFavorite.value = music.isFavorite;
            await audioHandler.updateMediaItem(MediaItem(
              // Specify a unique ID for each media item:
              id: music.id,
              // Metadata to display in the notification:
              artist: music.artist.name,
              title: music.name,
              artUri: Uri.parse(music.image),
            ));
            // await audioPlayer.setAudioSource(
            //   AudioSource.uri(
            //     Uri.parse(music.link),
            //     tag: MediaItem(
            //       // Specify a unique ID for each media item:
            //       id: music.id,
            //       // Metadata to display in the notification:
            //       artist: music.artist.name,
            //       title: music.name,
            //       artUri: Uri.parse(music.image),
            //     ),
            //   ),
            // );
          } on PlayerException catch (_) {
            Fluttertoast.showToast(msg: 'Error to play this music!');
            Get.back();
            isLoading.value = false;
            return;
          } on PlayerInterruptedException catch (_) {
            if (Get.currentRoute == Routes.musicDetails) {
              Fluttertoast.showToast(msg: 'Cant connect to server!');
              Get.back();
            }
            isLoading.value = false;
            return;
          } catch (_) {
            Fluttertoast.showToast(msg: 'Cant play this music');
            Get.back();
          }
          // audioPlayer.playerStateStream.listen((playerState) {
          //   final isPlaying = playerState.playing;
          //   final processingState = playerState.processingState;
          //   if (processingState == ProcessingState.loading ||
          //       processingState == ProcessingState.buffering) {
          //     buttonState.value = ButtonState.loading;
          //     //notifyListeners();
          //   } else if (processingState == ProcessingState.completed) {
          //     // print('object');
          //     // await audioPlayer.stop();
          //     if (letRepeat.value) {
          //       seek(const Duration(seconds: 0));
          //       audioHandler.play();
          //     } else if (nextMusics.value.isNotEmpty) {
          //       if (letShuffle.value) {
          //         nextMusics.value.shuffle();
          //       }
          //       getNextMusic();
          //     } else {
          //       seek(const Duration(seconds: 0));
          //       hasValue.value = false;
          //       audioHandler.stop();
          //     }
          //     // print('object');
          //   } else if (!isPlaying) {
          //     buttonState.value = ButtonState.paused;
          //     //notifyListeners();
          //   } else {
          //     buttonState.value = ButtonState.playing;
          //     //notifyListeners();
          //   }
          // });
          // audioPlayer.positionStream.listen((position) {
          //   final oldState = progressState;
          //   progressState.value = ProgressBarState(
          //     current: position,
          //     buffered: oldState.value.buffered,
          //     total: oldState.value.total,
          //   );
          //   //notifyListeners();
          // });
          // audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
          //   final oldState = progressState;
          //   progressState.value = ProgressBarState(
          //     current: oldState.value.current,
          //     buffered: bufferedPosition,
          //     total: oldState.value.total,
          //   );
          //   //notifyListeners();
          // });
          // audioPlayer.durationStream.listen((totalDuration) {
          //   final oldState = progressState;
          //   progressState.value = ProgressBarState(
          //     current: oldState.value.current,
          //     buffered: oldState.value.buffered,
          //     total: totalDuration ?? Duration.zero,
          //   );
          //   //notifyListeners();
          // });

          Either<ErrorResult, dynamic> result2 =
              await ServerRequest().fetchData(
            Urls.nextMusics(music.id),
          );
          result2.fold(
            (error) async {
              // await ErrorResult.showDlg(error.type, context);
              isLoading.value = false;
              //notifyListeners();
            },
            (result) async {
              // print(result);
              try {
                result['data'].forEach((element) {
                  nextMusics.add(MusicModel.fromJson(element));
                });
              } catch (_) {}
              if (nextMusics.isEmpty) {
                letNextMusic.value = false;
              }
              //notifyListeners();
            },
          );
          result2 = await ServerRequest().fetchData(
            Urls.previousMusics(music.id),
          );
          result2.fold(
            (error) async {
              // await ErrorResult.showDlg(error.type, context);
              isLoading.value = false;
              //notifyListeners();
            },
            (result) async {
              // print(result);
              try {
                result['data'].forEach((element) {
                  previousMusics.add(MusicModel.fromJson(element));
                });
              } catch (_) {}
              if (previousMusics.isEmpty) {
                letPreviousMusic.value = false;
              }
              // play();
              isLoading.value = false;
              //notifyListeners();
            },
          );
          // try {

          // } catch (e) {
          // audioHandler.updateMediaItem(MediaItem(
          //   id: music.link,
          //   // album: "Science Friday",
          //   title: music.name,
          //   artist: music.artist.name,
          //   artUri: Uri.parse(music.image),
          //   // artist: "Science Friday and WNYC Studios",
          //   // duration: const Duration(milliseconds: 5739820),
          //   // artUri: Uri.parse(
          //   //     'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
          // ));
          // }
          play(); // AwesomeNotifications().createNotification(
          //     content: NotificationContent(
          //       id: 10,
          //       channelKey: 'media_player',
          //       title: music.name,
          //       notificationLayout: NotificationLayout.MediaPlayer,
          //       progress: 50,
          //       locked: true, autoDismissible: false,
          //       icon: 'resource://drawable/icon',

          //       // autoDismissible: false, locked: true,
          //       // body: 'بازی آماده ی شروعه . . .',
          //     ),
          //     actionButtons: [
          //       NotificationActionButton(
          //         key: '1',
          //         label: '1',
          //         color: Colors.red,
          //       ),
          //       NotificationActionButton(
          //         key: '2',
          //         label: '2',
          //         color: Colors.white,
          //       ),
          //     ]);
          // audioPlayer.playerState.processingState.
          // AwesomeNotifications().createNotification(
          // AwesomeNotifications()
          //     .actionStream
          //     .listen((ReceivedNotification receivedNotification) {
          //   Get.toNamed(Routes.info);
          // });
          // audioHandler = await AudioService.init(
          //   builder: () => AudioPlayerHandler(
          //     MediaItem(
          //       id: music.link,
          //       // album: "Science Friday",
          //       title: music.name,
          //       artist: music.artist.name,
          //       artUri: Uri.parse(music.image),
          //       // artist: "Science Friday and WNYC Studios",
          //       // duration: const Duration(milliseconds: 5739820),
          //       // artUri: Uri.parse(
          //       //     'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
          //     ),
          //     audioPlayer,
          //   ),
          //   config: const AudioServiceConfig(
          //     androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
          //     androidNotificationChannelName: 'Audio playback',
          //     androidNotificationOngoing: true,
          //   ),
          // );
          // audioHandler.play();
          //   audioPlayer.playerStateStream.listen((playerState) {
          //     final isPlaying = playerState.playing;
          //     final processingState = playerState.processingState;
          //     if (processingState == ProcessingState.loading ||
          //         processingState == ProcessingState.buffering) {
          //       // buttonNotifier.value = ButtonState.loading;
          //     } else if (processingState == ProcessingState.completed) {
          //       if (letRepeat) {
          //         // seek(const Duration(seconds: 0));
          //         audioPlayer.play();
          //       } else if (nextMusics.isNotEmpty) {
          //         if (letShuffle) {
          //           nextMusics.shuffle();
          //         }
          //         Navigator.of(context).pushReplacementNamed(
          //           Routes.musicDetails,
          //           arguments: nextMusics[0].id,
          //           // arguments: video.id,
          //         );
          //       } else {
          //         // seek(const Duration(seconds: 0));
          //         audioPlayer.stop();
          //       }
          //       // print('object');
          //     } else if (!isPlaying) {
          //       // buttonNotifier.value = ButtonState.paused;
          //     } else {
          //       // buttonNotifier.value = ButtonState.playing;
          //     }
          //   });
        },
      );
    } else {
      try {
        typeIsMusic.value = false;
        letRepeat.value = true;
        await audioHandler.playFromUri(Uri.parse(rad!.link));
        radio = rad;
        hasValue.value = true;
        // audioPlayer.playerStateStream.listen((playerState) {
        //   final isPlaying = playerState.playing;
        //   final processingState = playerState.processingState;
        //   if (processingState == ProcessingState.loading ||
        //       processingState == ProcessingState.buffering) {
        //     buttonState.value = ButtonState.loading;
        //     //notifyListeners();
        //   } else if (processingState == ProcessingState.completed) {
        //     // if (letRepeat.value) {
        //     //   seek(const Duration(seconds: 0));
        //     //   audioPlayer.play();
        //     // } else if (nextMusics.isNotEmpty) {
        //     //   if (letShuffle.value) {
        //     //     nextMusics.shuffle();
        //     //   }
        //     //   Get.offNamed(
        //     //     Routes.musicDetails,
        //     //     arguments: nextMusics[0].id,
        //     //     // arguments: video.id,
        //     //   );
        //     // }
        //     // else {
        //     //   seek(const Duration(seconds: 0));
        //     //   hasValue.value = false;
        //     //   audioPlayer.stop();
        //     // }
        //     // print('object');
        //   } else if (!isPlaying) {
        //     buttonState.value = ButtonState.paused;
        //     //notifyListeners();
        //   } else {
        //     buttonState.value = ButtonState.playing;
        //     //notifyListeners();
        //   }
        // });
        await audioHandler.play();
      } on PlayerException catch (_) {
        Fluttertoast.showToast(msg: 'Error to play this radio!');
        // Get.back();
        isLoading.value = false;
        return;
      } on PlayerInterruptedException catch (_) {
        Fluttertoast.showToast(msg: 'Cant connect to server!');
        // Get.back();
        isLoading.value = false;
        return;
      } catch (_) {
        // Fallback for all errors
        // print(e);
      }
    }
  }

  changeFavorite(String musicId, bool isFavorite) async {
    // isLoading = true;
    // //notifyListeners();

    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.favorite,
      datas: {
        'rel_id': musicId,
        'rel_type': 'music',
        'status': isFavorite ? '1' : '0',
      },
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {},
    );
  }

  addToPlayList(String musicId, List<OptionModel> list) async {
    if (playListCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Select playlist first!');
      return;
    }
    isLoadingAddPlaylist.value = true;
    //notifyListeners();
    // isMyFavorite = !isMyFavorite;
    // //notifyListeners();

    final String playlistId =
        list.firstWhere((element) => element.title == playListCtrl.text).id!;

    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.attachToPlaylist(playlistId),
      datas: {
        'music_id': musicId,
      },
    );
    result.fold(
      (error) async {
        isLoadingAddPlaylist.value = false;
        Fluttertoast.showToast(msg: 'Error add this song to playlist!');
        playListCtrl.text = '';
        // await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // log(result.toString());
        Fluttertoast.showToast(msg: 'This song added to your playlist.');
        playListCtrl.text = '';
        isLoadingAddPlaylist.value = false;
        Get.back();
      },
    );
  }

  addDialog(
      BuildContext context, String musicId, List<OptionModel> datas) async {
    List<OptionModel> plylists = [];
    try {
      plylists = datas;
    } catch (_) {}
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: 400,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterWidget(
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const SimpleHeader(
                mainHeader: 'ADD To PLAYLIST',
                subHeader: '',
                showRightAngle: false,
              ),
              const SizedBox(height: 15),
              isLoadingAddPlaylist.value
                  ? const Center(
                      child: LoadingWidget(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 20),
                          StaticBottomSelector(
                            label: 'Choose the desired playlist',
                            controller: playListCtrl,
                            datas: plylists,
                          ),
                          const SizedBox(height: 25),
                          SubmitButton(
                            func: () => addToPlayList(musicId, plylists),
                            icon: null,
                            title: 'ADD To PLAYLIST',
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<OptionModel>> getPlaylists() async {
    List<OptionModel> playlists = [];
    Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.myPlaylists,
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        // isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // print(result);
        try {
          result['data'].forEach((element) {
            playlists.add(OptionModel(
                id: element['id'].toString(), title: element['name']));
          });
        } catch (_) {}
        // print(playlists.length);
      },
    );
    return playlists;
  }

  @override
  void onInit() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    );
    super.onInit();
  }
}
