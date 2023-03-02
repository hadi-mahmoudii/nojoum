// ignore_for_file: empty_catches

import 'package:better_player/better_player.dart';
import 'package:either_dart/either.dart';
// import 'package:flick_video_player/f
// lick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';

// import 'package:video_player/video_player.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Comment/Controllers/comment.dart';
import '../Models/video.dart';

class VideoDetailsController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  // late FlickManager flickManager;

  late BetterPlayerController controller;
  late VideoModel video;
  final String videoId;
  late var isMyFavorite = false.obs;
  VideoDetailsController(this.videoId);
  List<VideoModel> nextVideoes = [];

  late CommentController commentProvider;

  @override
  void onInit() async {
    commentProvider = Get.put(CommentController('video', videoId));
    commentProvider.getComments();
    await getDatas();
    super.onInit();
  }

  getDatas({bool resetPage = false}) async {
    final musicProvider = Get.find<MusicDetailsController>();

    await musicProvider.resetMusicDatas();
    isLoading.value = true;
    //notifyListeners();
    Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
      Urls.getVideo(videoId),
    );
    res.fold(
      (error) async {
        Fluttertoast.showToast(msg: 'Error to get video datas!');
        Get.back();
        return;
      },
      (result) async {
        // print(result);
        video = VideoModel.fromJson(result['data']);
        isMyFavorite.value = video.isFavorite;
      },
    );

    // controller = VideoPlayerController.network('https://nojoumhls.wns.live/hls/stream.m3u8')
    if (video.link.isEmpty) {
      Fluttertoast.showToast(msg: 'This video is Empty!');
      Get.back();
      return;
    }
    try {
      final String dataLink =
          'https://player.vimeo.com/video/${video.link.split('com/')[1]}/config';
      Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
        dataLink,
      );

      res.fold(
        (error) async {
          // await ErrorResult.showDlg(error.type, context);
          Fluttertoast.showToast(msg: 'Error to get video datas!');
          Get.back();
          return;
          //notifyListeners();
        },
        (result) async {
          // var response = await http.get(Uri.parse(dataLink));
          // var jsonData =
          //     jsonDecode(response.body)['request']['files']['progressive'];
          Map<String, String> urls = {};

          for (var data in result['request']['files']['progressive']) {
            // print(data['url'].toString());
            // print(data['quality'].toString());
            if (data['quality'].toString() == '240p') {
              continue;
            } else {
              urls[data['quality'].toString()] = data['url'].toString();
            }
            // print(data['url'].toString());
            // print(data['quality'].toString());

          }
          if (urls.keys.isNotEmpty) {
            final String url = urls[urls.keys.first]!;
            // print(url);
            // controller = VideoPlayerController.network(url)
            //   ..initialize().then((value) {
            //     flickManager = FlickManager(
            //       videoPlayerController: controller,
            //     );
            //     isLoading = false;
            //     notifyListeners();
            //   });
            BetterPlayerDataSource betterPlayerDataSource =
                BetterPlayerDataSource(
              BetterPlayerDataSourceType.network,
              url,
              resolutions: urls,
            );
            controller = BetterPlayerController(
              BetterPlayerConfiguration(
                controlsConfiguration: const BetterPlayerControlsConfiguration(
                  enableProgressText: true,
                  liveTextColor: Colors.white,
                  controlBarColor: Colors.black38,
                ),
                autoDetectFullscreenDeviceOrientation: true, autoPlay: true,
                // autoPlay: true,
                errorBuilder: (ctx, _) {
                  // Fluttertoast.showToast(msg: 'Error play this video!');
                  return Container(
                    height: Get.size.width * 9 / 16,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Error play video!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                allowedScreenSleep: false,
                // showPlaceholderUntilPlay: true,
                // placeholder: Image.network(video.image),
                looping: true,
                // fullScreenByDefault: true,
              ),
              betterPlayerDataSource: betterPlayerDataSource,
            );
          } else {
            Fluttertoast.showToast(msg: 'Error to get video datas!');
            Get.back();
            return;
          }
        },
      );
    } catch (error) {
      // print('=====> REQUEST ERROR: $error');
      Fluttertoast.showToast(msg: 'Error to get video datas!');
      Get.back();
      return;
    }

    Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.nextVodeoes(video.id),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // print(result);
        try {
          result['data'].forEach((element) {
            nextVideoes.add(VideoModel.fromJson(element));
          });
        } catch (e) {}

        //notifyListeners();
      },
    );
    isLoading.value = false;
    //notifyListeners();
    // controller = VideoPlayerController.network(video.link)
    //   ..initialize().then((value) async {
    //     flickManager = FlickManager(
    //       videoPlayerController: controller,
    //       autoInitialize: false,
    //       autoPlay: false,
    //     );
    //     Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
    //       Urls.nextVodeoes(video.id),
    //     );
    //     result.fold(
    //       (error) async {
    //         // await ErrorResult.showDlg(error.type, context);
    //         isLoading = false;
    //         //notifyListeners();
    //       },
    //       (result) {
    //         // print(result);
    //         try {
    //           result['data'].forEach((element) {
    //             nextVideoes.add(VideoModel.fromJson(element));
    //           });
    //         } catch (e) {}

    //         //notifyListeners();
    //       },
    //     );
    //     isLoading = false;
    //     //notifyListeners();
    //   });
  }

  changeFavorite(BuildContext context) async {
    isMyFavorite.value = !isMyFavorite.value;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.favorite,
      datas: {
        'rel_id': video.id,
        'rel_type': 'video',
        'status': isMyFavorite.value ? '1' : '0',
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {},
    );
  }

  @override
  void dispose() {
    try {
      controller.dispose();
    } catch (e) {}
    // try {
    //   controller.dispose();
    // } catch (e) {}
    super.dispose();
  }
}
