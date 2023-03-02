import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Feature/Post/Models/details.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Comment/Controllers/comment.dart';
import '../../Reaction/Controllers/reaction.dart';

class PostDetailsController extends GetxController
    with StateMixin<PostDetailsModel> {
  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  BetterPlayerController? videoController;
  late CommentController commentController;
  ReactionController reactionController = Get.find<ReactionController>();

  // @override
  // void onInit() async {
  //   super.onInit();
  // }

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    commentController = Get.put(CommentController('post', Get.arguments.id));
    await commentController.getComments();
    super.onInit();
    if (Get.arguments.isVideo) {
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        Get.arguments.url,
      );
      videoController = BetterPlayerController(
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
      videoController!.play();
    }
    change(Get.arguments, status: RxStatus.success());
  }

  getDatas({bool resetPage = false}) async {
    if (resetPage) {
      currentPage = 1;
      lockPage.value = false;
    }
    if (lockPage.value) return;
    if (currentPage == 1) {
      change(null, status: RxStatus.loading());
    } else {
      change(state, status: RxStatus.loadingMore());
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMusics(currentPage.toString()),
    );
    result.fold(
      (error) async {
        change(null, status: RxStatus.error(error.type.toString()));
      },
      (result) {
        log(result.toString());
        List<PostDetailsModel> posts = [];
        result['data'].forEach((element) {
          posts.add(PostDetailsModel.fromJson(element));
        });
        if (currentPage == 1) {
          currentPage += 1;
          // isLoading.value = false;
          //notifyListeners();
        } else {
          if (posts.isNotEmpty) {
            // posts = state! + posts;
            currentPage += 1;
          } else {
            lockPage.value = true;
          }
          // isLoadingMore.value = false;
          //notifyListeners();
        }
        change(null, status: RxStatus.success());
      },
    );
  }

  @override
  void dispose() {
    try {
      videoController!.dispose();
    } catch (_) {}
    super.dispose();
  }
}
