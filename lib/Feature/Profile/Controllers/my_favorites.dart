import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Music/Model/music.dart';
import '../../Video/Models/video.dart';

class MyFavoritesController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  // int currentPage = 1;

  List<MusicModel> musics = [];
  List<VideoModel> videoes = [];
  // List<MyCustomProgramOverviewModel> myCustomPrograms = [];
  @override
  void onInit() async {
    await getDatas();
    super.onInit();
  }

  getDatas({bool resetPage = false}) async {
    if (resetPage) {
      musics = [];
      videoes = [];
    }
    // if (currentPage == 1) {
    // datas = [];
    // myCustomPrograms = [];
    isLoading.value = true;
    // } else {
    //   isLoadingMore = true;
    //   notifyListeners();
    // }
    final Either<ErrorResult, dynamic> result =
        await ServerRequest().fetchData(Urls.myMusicFavorites);
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // log(result.toString());
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          musics.add(MusicModel.fromJson(element));
          // print(result['children']);
        });
        // isLoading = false;
        // notifyListeners();
      },
    );
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.myVideoFavorites);
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // log(result.toString());
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          videoes.add(VideoModel.fromJson(element));
          // print(result['children']);
        });
        isLoading.value = false;
      },
    );
  }
}
