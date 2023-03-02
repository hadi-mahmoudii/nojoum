import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';

class LiveVideoController extends GetxController {
  var isLoading = true.obs;
  var livePlaying = false.obs;
  var letShowLive = true.obs;

  // this use to pause or full stop live video
  stopLive(bool isFullStop) async {
    if (isFullStop) {
      letShowLive.value = false;
    }
    try {
      await controller.pause();
    } catch (_) {}
    livePlaying.value = false;
  }

  late BetterPlayerController controller;

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
    controller.addEventsListener((event) async {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        controller.setVolume(0.0);
      }
    });
    isLoading.value = false;
    livePlaying.value = true;
  }
}
