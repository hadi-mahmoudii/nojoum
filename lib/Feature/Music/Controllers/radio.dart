import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../General/Model/radio.dart';

class RadioDetailsController extends GetxController {
  // var isLoading = false.obs;
  // var isLoadingMore = false.obs;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;

  final RadioModel radio;

  RadioDetailsController(this.radio);
  // @override
  // void onInit() async {
  //   await fetchData();
  //   super.onInit();
  // }

  // fetchData() async {
  //   // isLoading.value = true;
  //   //notifyListeners();
  //   final musicProvider = Get.find<MusicDetailsController>();

  //   await musicProvider.resetMusicDatas();
  //   isLoading.value = false;
  //   //notifyListeners();
  //   // final Either<ErrorResult, dynamic> result3 =
  //   //     await ServerRequest().fetchData(
  //   //   'Urls.login',
  //   // );
  //   // result3.fold(
  //   //   (error) async {
  //   //     // await ErrorResult.showDlg(error.type, context);
  //   //     isLoading = false;
  //   //     //notifyListeners();
  //   //   },
  //   //   (result) {
  //   //     try {
  //   //       // blog = BlogModel.fromJson(result['data']);
  //   //       isLoading = false;
  //   //       //notifyListeners();
  //   //     } catch (e) {
  //   //       Fluttertoast.showToast(msg: 'خطا در دریافت اطلاعات!');
  //   //       Get.back();
  //   //     }
  //   //   },
  //   // );
  // }
}
