import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Model/music.dart';

class MusicListController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  var datas = [].obs;
  @override
  void onInit() async {
    await fetchDatas();
    super.onInit();
  }

  fetchDatas({bool resetPage = false, bool resetFilter = false}) async {
    if (resetPage) {
      currentPage = 1;
      lockPage.value = false;
      datas.clear();
    }
    if (lockPage.value) return;
    if (currentPage == 1) {
      // blogs = [];
      isLoading.value = true;
      //notifyListeners();
    } else {
      isLoadingMore.value = true;
      //notifyListeners();
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMusics(currentPage.toString()),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        log(result.toString());
        result['data'].forEach((element) {
          datas.add(MusicModel.fromJson(element));
        });
        if (currentPage == 1) {
          currentPage += 1;
          isLoading.value = false;
          //notifyListeners();
        } else {
          if (result['data'].length > 0) {
            currentPage += 1;
          } else {
            lockPage.value = true;
          }
          isLoadingMore.value = false;
          //notifyListeners();
        }
      },
    );
  }
}
