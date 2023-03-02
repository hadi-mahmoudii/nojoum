import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  List datas = [];

  // fetchDatas(BuildContext context,
  //     {bool resetPage = false, bool resetFilter = false}) async {
  //   if (resetPage) {
  //     currentPage = 1;
  //     lockPage.value = false;
  //   }
  //   if (lockPage.value) return;
  //   if (currentPage == 1) {
  //     // blogs = [];
  //     isLoading.value = true;
  //   } else {
  //     isLoadingMore.value = true;
  //   }
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     'Urls.login',
  //   );
  //   result.fold(
  //     (error) async {
  //       // await ErrorResult.showDlg(error.type, context);
  //       isLoading.value = false;
  //     },
  //     (result) {
  //       // print(result);
  //       // result['data'].forEach((element) {
  //       //   blogs.add(BlogModel.fromJson(element));
  //       // });
  //       if (currentPage == 1) {
  //         currentPage += 1;
  //         isLoading.value = false;
  //       } else {
  //         if (result['data'].length > 0) {
  //           currentPage += 1;
  //         } else {
  //           lockPage.value = true;
  //         }
  //         isLoadingMore.value = false;
  //       }
  //     },
  //   );
  // }

  // // fetchData(BuildContext context) async {
  // //   isLoading = true;
  // //   notifyListeners();

  // //   final Either<ErrorResult, dynamic> result3 =
  // //       await ServerRequest().fetchData(
  // //     'Urls.login',
  // //   );
  // //   result3.fold(
  // //     (error) async {
  // //       // await ErrorResult.showDlg(error.type, context);
  // //       isLoading = false;
  // //       notifyListeners();
  // //     },
  // //     (result) {
  // //       try {
  // //         // blog = BlogModel.fromJson(result['data']);
  // //         isLoading = false;
  // //         notifyListeners();
  // //       } catch (e) {
  // //         Fluttertoast.showToast(msg: 'خطا در دریافت اطلاعات!');
  // //         Get.back();
  // //       }
  // //     },
  // //   );
  // // }

}
