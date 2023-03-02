import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Feature/Post/Models/story.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';

class ExploreController extends GetxController
    with StateMixin<List<StoryModel>> {
  TextEditingController mediaCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int storiesPage = 1;
  var lockStories = false.obs;

  RxBool isLoadingMoreStories = false.obs;

  @override
  void onReady() async {
    super.onReady();
    await getStories();
  }

  RxInt storiesRowsCount = RxInt(0);
  getStories({bool resetPage = false}) async {
    if (resetPage) {
      storiesPage = 1;
      lockStories.value = false;
    }
    if (lockStories.value) return;
    if (storiesPage == 1) {
      change([], status: RxStatus.loading());
    } else {
      isLoadingMoreStories.value = true;
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.stories(storiesPage.toString()),
    );
    result.fold(
      (error) async {
        isLoadingMoreStories.value = false;
        change([], status: RxStatus.error(error.type.toString()));
      },
      (result) {
        log(result.toString());
        List<StoryModel> apiStories = [];
        try {
          result['data'].forEach((element) {
            apiStories.add(StoryModel.fromJson(element));
          });
        } catch (_) {}
        if (storiesPage == 1) {
          storiesPage += 1;
        } else {
          if (apiStories.isNotEmpty) {
            apiStories = state! + apiStories;
            storiesPage += 1;
          } else {
            lockStories.value = true;
          }
          isLoadingMoreStories.value = false;
        }
        storiesRowsCount.value = (apiStories.length / 5).ceil();
        change(apiStories, status: RxStatus.success());
      },
    );
  }

  List<StoryModel> getRowStoryPart(int index) {
    List<StoryModel> stories = [];
    for (var i = index * 5; i < (index + 1) * 5; i++) {
      try {
        stories.add(state![i]);
      } catch (_) {}
    }
    return stories;
  }

  sendStory(XFile selectedFile) async {
    try {
      final fileBytes = selectedFile.readAsBytes();
      final Either<ErrorResult, dynamic> result =
          await ServerRequest().sendFile(Urls.sendStory, {
        'file': MultipartFile(fileBytes, filename: selectedFile.name),
      });
      result.fold(
        (error) async {
          // change([], status: RxStatus.error(error.type.toString()));
        },
        (result) {
          Fluttertoast.showToast(msg: 'Post uploaded');
          Get.back();
        },
      );
    } catch (_) {
      Fluttertoast.showToast(msg: 'Error upload image!');
    }
  }
}
