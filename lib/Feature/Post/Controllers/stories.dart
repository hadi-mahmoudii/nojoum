import 'dart:io';

import 'package:camera/camera.dart';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:nojoum/Core/Models/server_request.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/story.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:dio/dio.dart' as di;

class StoriesController extends GetxController {
  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  // @override
  // void onReady() async {
  //   super.onReady();
  //   await getStories();
  // }

  int storiesPage = 1;
  var lockStories = false.obs;
  RxBool isLoadingStories = false.obs;
  RxBool isLoadingMoreStories = false.obs;

  RxList<StoryModel> stories = <StoryModel>[].obs;

  di.CancelToken cancelToken = di.CancelToken();
  getStories({bool resetPage = false}) async {
    if (resetPage) {
      storiesPage = 1;
      lockStories.value = false;
      isLoadingMoreStories.value = false;
      isLoadingStories.value = false;
    }
    if (lockStories.value || isLoadingMoreStories.value) return;
    if (storiesPage == 1) {
      isLoadingStories.value = true;
    } else {
      isLoadingMoreStories.value = true;
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.stories(storiesPage.toString()),
    );
    result.fold(
      (error) async {
        isLoadingMoreStories.value = false;
        isLoadingStories.value = false;
      },
      (result) {
        // log(result.toString());
        List<StoryModel> apiStories = [];
        try {
          result['data'].forEach((element) {
            apiStories.add(StoryModel.fromJson(element));
          });
        } catch (_) {}

        if (storiesPage == 1) {
          storiesPage += 1;
          stories.value = apiStories;
          isLoadingStories.value = false;
        } else {
          if (apiStories.isNotEmpty) {
            stories.value += apiStories;
            storiesPage += 1;
          } else {
            lockStories.value = true;
          }
          isLoadingMoreStories.value = false;
        }
      },
    );
  }

  RxDouble fileUploadprogress = RxDouble(0.0);
  changeProgressPercent(double progress) {
    fileUploadprogress.value = progress;
  }

  sendStory(XFile selectedFile) async {
    Get.defaultDialog(
      backgroundColor: Colors.black54,
      barrierDismissible: false,
      title: 'Uploading',
      titleStyle: const TextStyle(color: Color(0XFFFFD600)),
      // cancel: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   child: SubmitButton2(
      //     func: () {
      //       cancelToken.cancel();
      //       Get.back();
      //       Get.back();
      //     },
      //     icon: null,
      //     title: 'Cancel',
      //     color: const Color(0XFFFFD600),
      //   ),
      // ),
      content: const Text(
        '''Please wait
      Your story is uploading . . .''',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0XFFFFD600),
        ),
      ),
    );
    final LightCompressor _lightCompressor = LightCompressor();
    final dynamic response = await _lightCompressor.compressVideo(
      path: selectedFile.path,
      destinationPath: await _destinationFile,
      videoQuality: VideoQuality.high,
      isMinBitrateCheckEnabled: false,
    );

    XFile compressedVideo = XFile(response.destinationPath);
    try {
      // final Either<ErrorResult, dynamic> result =
      //     await ServerRequest().sendFile(Urls.sendStory, {
      //   'file': MultipartFile(await compressedVideo.readAsBytes(),
      //       filename: selectedFile.name),
      // });
      final Either<ErrorResult, dynamic> result =
          await ServerRequest().sendVideo(
        compressedVideo,
        changeProgressPercent,
      );
      result.fold(
        (error) async {
          Fluttertoast.showToast(msg: 'Error upload story!');
          Get.back();
        },
        (result) {
          Fluttertoast.showToast(msg: 'Story uploaded');
          Get.back();
          Get.back();
          Get.back();
        },
      );
    } on di.DioError catch (e) {
      if (e.type == di.DioErrorType.cancel) {
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error upload story!');
      Get.back();
    }
  }

  Future<String> get _destinationFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    if (GetPlatform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir = await path.getExternalStorageDirectories(
          type: path.StorageDirectory.movies);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await path.getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }

  Future<String> selectImage() async {
    try {
      var result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: false,
        type: FileType.video,
      );
      if (result!.files.isNotEmpty) {
        if (result.files[0].size > (30 * 1024 * 1024)) {
          Fluttertoast.showToast(msg: 'Select a file smaller than 30 mg!');
          return '';
        } else {
          return result.files[0].path!;
        }
      }
    } catch (_) {}
    return '';
  }
}
