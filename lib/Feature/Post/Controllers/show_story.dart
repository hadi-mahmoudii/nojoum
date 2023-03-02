import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Core/Widgets/error_result.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';
import 'package:nojoum/Feature/Post/Models/story.dart';

import '../../../Core/Config/urls.dart';

class ShowStoryController extends GetxController with StateMixin<StoryModel> {
  late BetterPlayerController videoController;

  @override
  void onInit() async {
    try {
      Get.find<MusicDetailsController>().resetMusicDatas();
    } catch (_) {}
    change(null, status: RxStatus.loading());
    await getData(Get.arguments.toString());
    // change(Get.arguments, status: RxStatus.success());
    super.onInit();
  }

  // initVideoPlayer() async {
  //   if (state != null) {
  //     BetterPlayerConfiguration betterPlayerConfiguration =
  //         BetterPlayerConfiguration(
  //       aspectRatio: Get.size.width / Get.size.height,
  //       deviceOrientationsOnFullScreen: [
  //         DeviceOrientation.portraitUp,
  //         DeviceOrientation.portraitDown
  //       ],
  //       // fit: BoxFit.contain,
  //       // looping: true,
  //       expandToFill: true,
  //       autoPlay: true,
  //       controlsConfiguration: const BetterPlayerControlsConfiguration(
  //         showControls: false,
  //       ),
  //     );
  //     videoController = BetterPlayerController(betterPlayerConfiguration);
  //     BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
  //       state!.video,
  //     );
  //     videoController.setupDataSource(dataSource);
  //     videoController.addEventsListener((event) {
  //       if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
  //         if (story.nextId != null) {
  //           getData(storyId)
  //         } else {
  //           Get.back();
  //         }
  //       }
  //     });
  //     // await videoController.play();
  //   }
  // }

  getData(String storyId) async {
    change(null, status: RxStatus.loading());
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getStory(storyId),
    );
    result.fold(
      (error) async {
        change(null, status: RxStatus.error(error.type.toString()));
      },
      (result) {
        log(result.toString());
        try {
          StoryModel story = StoryModel.fromJson(result['data']);
          BetterPlayerConfiguration betterPlayerConfiguration =
              const BetterPlayerConfiguration(
            // aspectRatio: Get.size.width / Get.size.height,
            aspectRatio: 9 / 16,
            deviceOrientationsOnFullScreen: [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown
            ],
            // fit: BoxFit.fill,
            // looping: true,
            // expandToFill: true,
            autoPlay: true,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              showControls: false,
            ),
          );
          videoController = BetterPlayerController(betterPlayerConfiguration);
          BetterPlayerDataSource dataSource = BetterPlayerDataSource.network(
            story.video,
          );
          videoController.setupDataSource(dataSource);
          videoController.addEventsListener((event) {
            if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
              if (story.nextId != null) {
                getData(story.nextId.toString());
                // Get.offAndToNamed(Routes.showStory, arguments: state!.nextId!);
              } else {
                Get.back();
              }
            }
          });
          log(videoController.videoPlayerController!.value.aspectRatio
              .toString());
          change(story, status: RxStatus.success());
        } catch (_) {
          Fluttertoast.showToast(msg: 'Error play story!');
          Get.back();
        }
      },
    );
  }

  @override
  void dispose() {
    try {
      videoController.dispose();
      Get.delete<ShowStoryController>(force: true);
    } catch (_) {}
    super.dispose();
  }
}
