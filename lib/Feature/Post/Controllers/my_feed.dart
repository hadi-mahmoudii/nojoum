import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Feature/Post/Models/details.dart';
import 'package:nojoum/Feature/Reaction/Controllers/reaction.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';

class MyFeedController extends GetxController
    with StateMixin<List<PostDetailsModel>> {
  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  ReactionController reactionController = Get.find<ReactionController>();
  int currentPage = 1;
  var lockPage = false.obs;
  @override
  void onReady() async {
    super.onReady();
    await getPosts();
  }

  getPosts({bool resetPage = false}) async {
    if (resetPage) {
      currentPage = 1;
      lockPage.value = false;
    }
    if (lockPage.value) return;
    if (currentPage == 1) {
      change([], status: RxStatus.loading());
    } else {
      change(state, status: RxStatus.loadingMore());
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getPosts(currentPage.toString()),
    );
    result.fold(
      (error) async {
        change([], status: RxStatus.error(error.type.toString()));
      },
      (result) {
        log(result.toString());
        List<PostDetailsModel> posts = [];
        result['data'].forEach((element) {
          posts.add(PostDetailsModel.fromJson(element));
        });
        if (currentPage == 1) {
          currentPage += 1;
          // isLoading.value = false;
          //notifyListeners();
        } else {
          posts = state! + posts;
          if (result['data'].isNotEmpty) {
            currentPage += 1;
          } else {
            lockPage.value = true;
          }
          // isLoadingMore.value = false;
          //notifyListeners();
        }
        change(posts, status: RxStatus.success());
      },
    );
  }
}
