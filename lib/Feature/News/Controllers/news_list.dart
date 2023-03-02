import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Models/news.dart';

class NewsListController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var lockPage = false.obs;

  ScrollController scrollController = ScrollController();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();

  int currentPage = 1;

  List<NewsModel> newsList = [];
  List<OptionModel> categories = [];
  // List<MyCustomProgramOverviewModel> myCustomPrograms = [];
  @override
  void onInit() async {
    await getNews();
    super.onInit();
  }

  getNews({bool resetPage = false, bool fromSearch = false}) async {
    if (currentPage == 1) {
      if (fromSearch) {
        if (searchCtrl.text.length < 3) {
          Fluttertoast.showToast(msg: 'Enter atleast 3 characters!');
          return;
        }
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      newsList = [];

      //notifyListeners();
    } else {
      isLoadingMore.value = true;
      //notifyListeners();
    }

    // print(Urls.globalnewsList(searchCtrl.text));
    final Either<ErrorResult, dynamic> result2 = await ServerRequest()
        .fetchData(Urls.getNews(searchCtrl.text, currentPage.toString()));
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // log(result.toString());
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          newsList.add(NewsModel.fromJson(element));
          // print(result['children']);
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
        isLoading.value = false;
        isLoadingMore.value = false;
        //notifyListeners();
      },
    );
  }
}
