import 'dart:developer';
// import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:light_compressor/light_compressor.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Feature/Post/Screens/add.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Screens/crop_page.dart';
// import 'package:path_provider/path_provider.dart' as path;

class AddPostController extends GetxController with StateMixin<dynamic> {
  TextEditingController descCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();

  late BetterPlayerController videoController;

  Rx<PlatformFile?> selectedFile = Rx(null);
  sendDatas({bool resetPage = false}) async {
    change(dynamic, status: RxStatus.loading());
    final Either<ErrorResult, dynamic> result =
        await ServerRequest().sendData(Urls.posts, datas: {});
    result.fold(
      (error) async {
        change([], status: RxStatus.error(error.type.toString()));
      },
      (result) {
        log(result.toString());
      },
    );
  }

  selectImage() async {
    change(dynamic, status: RxStatus.loading());

    try {
      await FilePicker.platform
          .pickFiles(
        withData: true,
        allowMultiple: false,
        type: FileType.media,
      )
          .then((files) async {
        if (files!.files.isNotEmpty) {
          if (files.files[0].size > (30 * 1024 * 1024)) {
            Fluttertoast.showToast(msg: 'Select a file smaller than 30 mg!');
            return;
          } else {
            if (!imageExtentions.contains(files.files[0].extension)) {
              BetterPlayerConfiguration betterPlayerConfiguration =
                  const BetterPlayerConfiguration(
                aspectRatio: 9 / 16,
                // fit: BoxFit.contain,
              );
              videoController =
                  BetterPlayerController(betterPlayerConfiguration);
              BetterPlayerDataSource dataSource = BetterPlayerDataSource.memory(
                  files.files[0].bytes!,
                  videoExtension: files.files[0].extension);
              videoController.setupDataSource(dataSource);
              selectedFile.value = files.files[0];
            } else {
              Get.to(
                () => CropperPage(
                  title: 'cropper',
                  imageFile: files.files[0],
                  cropped: (final PlatformFile file) {
                    selectedFile.value = file;
                    Get.back();
                    refresh();
                  },
                ),
              );
            }
          }
        }
      });
    } catch (_) {}
    change(dynamic, status: RxStatus.success());
  }

  sendPost() async {
    if (selectedFile.value == null && descCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Select a file or type post details send!');
      return;
    }
    // if (descCtrl.text.length < 15) {
    //   Fluttertoast.showToast(msg: 'Enter atleast 15 characters!');
    //   return;
    // }
    // try {
    // change(dynamic, status: RxStatus.loading());
    Get.defaultDialog(
      backgroundColor: Colors.black54,
      barrierDismissible: false,
      title: 'Uploading',
      titleStyle: const TextStyle(color: Color(0XFFFFD600)),
      content: const Text(
        '''Please wait
      Your post is uploading . . .''',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0XFFFFD600),
        ),
      ),
    );
    late Either<ErrorResult, dynamic> result;
    if (selectedFile.value == null) {
      result = await ServerRequest().sendPost(null, null, descCtrl.text);
    } else {
      result = await ServerRequest().sendPost(
          selectedFile.value!.bytes, selectedFile.value!.name, descCtrl.text);
    }

    result.fold(
      (error) async {
        // change([], status: RxStatus.error(error.type.toString()));
        Fluttertoast.showToast(msg: 'Error to upload post');
        Get.back();
      },
      (result) {
        log(result.toString());
        Fluttertoast.showToast(msg: 'Post uploaded');
        Get.back();
        Get.back();
      },
    );
    // } catch (_) {
    //   Fluttertoast.showToast(msg: 'Error to upload post');
    //   Get.back();
    // }
  }

  @override
  void onReady() {
    change(dynamic, status: RxStatus.success());

    super.onReady();
  }

  // Future<String> get _destinationFile async {
  //   String directory;
  //   final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
  //   if (GetPlatform.isAndroid) {
  //     // Handle this part the way you want to save it in any directory you wish.
  //     final List<Directory>? dir = await path.getExternalStorageDirectories(
  //         type: path.StorageDirectory.movies);
  //     directory = dir!.first.path;
  //     return File('$directory/$videoName').path;
  //   } else {
  //     final Directory dir = await path.getLibraryDirectory();
  //     directory = dir.path;
  //     return File('$directory/$videoName').path;
  //   }
  // }
}
