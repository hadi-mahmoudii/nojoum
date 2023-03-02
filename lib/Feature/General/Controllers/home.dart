import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Model/secton.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  // bool isLoadingMore = false;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  // int currentPage = 1;
  var lockPage = false.obs;
  RxList<HomeSectionModel> sections = <HomeSectionModel>[].obs;
  @override
  void onInit() async {
    await fetchDatas();
    super.onInit();
  }

  fetchDatas({bool resetPage = false, bool resetFilter = false}) async {
    if (resetPage) {
      sections.clear();
    }
    // final appSession = Get.find<AppSession>();
    // final liveController = Get.find<LiveVideoController>();
    // await liveController.getLive();
    isLoading.value = true;
    // notifyListeners();
    // List<SectionModel> homeSections = [];
    Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
      Urls.getSections,
    );
    res.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // print(result);
        // try {
        result['data'].forEach((element) {
          sections.add(HomeSectionModel.fromJson(element));
        });
        // } catch (e) {}
      },
    );
    isLoading.value = false;
  }
}
