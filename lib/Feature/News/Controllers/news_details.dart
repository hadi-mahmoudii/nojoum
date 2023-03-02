import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Comment/Controllers/comment.dart';
import '../Models/news.dart';

class NewsDetailsController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var haveVideo = false.obs;
  late BetterPlayerController controller;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  late String newsId;
  late NewsModel news;
  List<NewsModel> similarNews = [];
  NewsDetailsController();

  late CommentController commentProvider;

  getDatas({bool resetPage = false, bool fromSearch = false}) async {
    isLoading.value = true;
    newsId = Get.arguments;
    commentProvider = Get.put(CommentController('news', newsId));
    await commentProvider.getComments();
    final Either<ErrorResult, dynamic> result3 =
        await ServerRequest().fetchData(
      Urls.getSingleNews(newsId),
    );
    result3.fold(
      (error) async {
        isLoading.value = false;
      },
      (result) {
        log(result.toString());
        try {
          news = NewsModel.fromJson(result['data']);
        } catch (e) {
          Fluttertoast.showToast(msg: 'Error fetch datas');
          Get.back();
          return;
        }
      },
    );
    similarNews = [];
    try {
      final String dataLink =
          'https://player.vimeo.com/video/${news.video.split('com/')[1]}/config';
      Either<ErrorResult, dynamic> res = await ServerRequest().fetchData(
        dataLink,
      );
      res.fold(
        (error) async {
          isLoading.value = false;
        },
        (result) async {
          log(result['request']['files'].toString());
          Map<String, String> urls = {};
          for (var data in result['request']['files']['progressive']) {
            if (data['quality'].toString() == '240p') {
              continue;
            } else {
              urls[data['quality'].toString()] = data['url'].toString();
            }
          }
          if (urls.keys.isNotEmpty) {
            final String url = urls[urls.keys.first]!;
            BetterPlayerDataSource betterPlayerDataSource =
                BetterPlayerDataSource(
              BetterPlayerDataSourceType.network,
              url,
              resolutions: urls,
            );
            controller = BetterPlayerController(
              BetterPlayerConfiguration(
                controlsConfiguration: const BetterPlayerControlsConfiguration(
                  enableProgressText: true,
                  liveTextColor: Colors.white,
                  controlBarColor: Colors.black38,
                ),
                autoDetectFullscreenDeviceOrientation: true,
                errorBuilder: (ctx, _) {
                  return Container(
                    height: Get.size.width * 9 / 16,
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Error play video!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                allowedScreenSleep: false,
                looping: true,
              ),
              betterPlayerDataSource: betterPlayerDataSource,
            );
            haveVideo.value = true;
          } else {
            haveVideo.value = false;
          }
        },
      );
    } catch (error) {
      haveVideo.value = false;
    }
    final Either<ErrorResult, dynamic> result =
        await ServerRequest().fetchData(Urls.getSimilarNews(news.id));
    result.fold(
      (error) async {
        isLoading.value = false;
      },
      (result) {
        result['data'].forEach((element) {
          similarNews.add(NewsModel.fromJson(element));
        });
        isLoading.value = false;
        isLoadingMore.value = false;
      },
    );
  }

  @override
  void onInit() {
    getDatas();
    super.onInit();
  }
}
