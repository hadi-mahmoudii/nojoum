import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/singer.dart';

class SingerInfoController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  // final String singerId;

  // SingerInfoProvider({required this.singerId});

  late SingerModel singer;
  final String singerId;

  SingerInfoController(this.singerId);
  @override
  void onInit() async {
    await getDatas();
    super.onInit();
  }

  getDatas({bool resetPage = false}) async {
    isLoading.value = true;

    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getSinger(singerId),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // print(result);
        singer = SingerModel.fromJson(result['data']);
        // for (var item in result['data'].keys) {
        //   print(item);
        //   print(result['data'][item]);
        // }
        // program = OurProgramModel.fromJson(result['data']);
        // result['data'].forEach((element) {
        //   // print(element);
        //   programs.add(ProgramOverviewModel.fromJson(element));
        //   // print(result['children']);
        // });
        isLoading.value = false;
      },
    );
  }
}
