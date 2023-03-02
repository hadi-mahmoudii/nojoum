import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';

// create this to prevent errors of duplication of controllers
class LiveScreenVideoController extends GetxController {
  var isLoading = true.obs;
  var livePlaying = false.obs;
  var letShowLive = true.obs;

  changeLetShowLive(bool value) async {
    if (!value) {
      await controller.pause();
    }
    letShowLive.value = value;
  }

  late BetterPlayerController controller;
  // late FlickManager flickManager;

  @override
  void onInit() async {
    await getLive();
    super.onInit();
  }

  Future getLive({bool resetPage = false}) async {
    isLoading.value = true;
    if (resetPage) {
      letShowLive.value = true;
    }
    // notifyListeners();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Urls.homeLive,
      liveStream: true,
      // resolutions: urls,
    );
    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        controlsConfiguration: const BetterPlayerControlsConfiguration(
          enableProgressText: true,
          liveTextColor: Colors.white,
          controlBarColor: Colors.black38,
        ),
        autoDetectFullscreenDeviceOrientation: true,
        autoPlay: true,
        errorBuilder: (ctx, _) => const Center(
          child: Text('Error play live!'),
        ),
        allowedScreenSleep: false,
        showPlaceholderUntilPlay: true,
        // placeholder: Image.network(widget.imageLink!),
        looping: true,
        // fullScreenByDefault: true,
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    isLoading.value = false;
    livePlaying.value = true;
    // notifyListeners();
    // controller = VideoPlayerController.network(Urls.homeLive)
    //   ..initialize().then((value) async {
    //     flickManager = FlickManager(
    //       videoPlayerController: controller,
    //       autoInitialize: false,
    //       autoPlay: false,
    //     );
    //     await controller.play();
    //     livePlaying = true;
    //     isLoading = false;
    //     notifyListeners();
    //   });
  }

  changeLiveStatus(bool isPause) async {
    // livePlaying.value = !isPause;
    // // isLoading.value = false;
    // if (isPause) {
    //   // Get.delete<LiveScreenVideoController>();
    //   // try {
    //   //   controller.dispose();
    //   // } catch (e) {}
    // } else {
    //   try {
    //     await getLive();
    //   } catch (_) {}
    // }
    // notifyListeners();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  // @override
  // void dispose() {
  //   try {
  //     controller.dispose();
  //   } catch (e) {}
  //   super.dispose();
  // }
}
