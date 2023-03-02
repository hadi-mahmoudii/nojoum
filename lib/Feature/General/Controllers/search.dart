import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/server_request.dart';
import 'package:nojoum/Feature/Music/Model/music.dart';
import 'package:nojoum/Feature/Music/Model/playlist.dart';
import 'package:nojoum/Feature/Video/Models/video.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Widgets/error_result.dart';

class SearchMediaController extends GetxController {
  TextEditingController searchCtrl = TextEditingController();
  RxInt currentTabIndex = RxInt(0);

  ScrollController videoScrollCtrl = ScrollController();
  RxList<VideoModel> videos = <VideoModel>[].obs;
  RxBool isLoadingVideos = false.obs;
  RxBool isLoadingMoreVideos = false.obs;
  var lockVideos = false.obs;
  int videosPage = 1;

  ScrollController playlistScrollCtrl = ScrollController();
  RxList<PlayListModel> playlists = <PlayListModel>[].obs;
  RxBool isLoadingPlaylists = false.obs;
  RxBool isLoadingMorePlaylists = false.obs;
  var lockPlaylists = false.obs;
  int playlistsPage = 1;

  ScrollController musicScrollCtrl = ScrollController();
  RxList<MusicModel> musics = <MusicModel>[].obs;
  RxBool isLoadingMusics = false.obs;
  RxBool isLoadingMoreMusics = false.obs;
  var lockMusics = false.obs;
  int musicsPage = 1;

  late TabController tabCtrl;

  changeTabIndex(int index) {
    currentTabIndex.value = index;
  }

  getVideos({bool resetPage = false, bool resetFilter = false}) async {
    if (resetPage) {
      videos.clear();
      videosPage = 1;
      lockVideos.value = false;
    }
    if (lockVideos.value) return;
    if (videosPage == 1) {
      isLoadingVideos.value = true;
    } else {
      isLoadingMoreVideos.value = true;
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getVideoes(videosPage.toString(), filter: searchCtrl.text),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoadingVideos.value = false;
        isLoadingMoreVideos.value = false;
      },
      (result) {
        // print(result);
        result['data'].forEach((element) {
          try {
            videos.add(VideoModel.fromJson(element));
          } catch (_) {}
        });
        if (videosPage == 1) {
          videosPage += 1;
          isLoadingVideos.value = false;
        } else {
          if (result['data'].length > 0) {
            videosPage += 1;
          } else {
            lockVideos.value = true;
          }
          isLoadingMoreVideos.value = false;
        }
      },
    );
  }

  getMusics({bool resetPage = false, bool resetFilter = false}) async {
    if (resetPage) {
      musicsPage = 1;
      lockMusics.value = false;
      musics.clear();
    }
    if (lockMusics.value) return;
    if (musicsPage == 1) {
      isLoadingMusics.value = true;
    } else {
      isLoadingMoreMusics.value = true;
    }
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getMusics(musicsPage.toString(), filter: searchCtrl.text),
    );
    result.fold(
      (error) async {
        isLoadingMusics.value = false;
        isLoadingMoreMusics.value = false;
      },
      (result) {
        result['data'].forEach((element) {
          musics.add(MusicModel.fromJson(element));
        });
        if (musicsPage == 1) {
          musicsPage += 1;
          isLoadingMusics.value = false;
        } else {
          if (result['data'].length > 0) {
            musicsPage += 1;
          } else {
            lockMusics.value = true;
          }
          isLoadingMoreMusics.value = false;
        }
      },
    );
  }

  getPlaylists({bool resetPage = false}) async {
    if (resetPage) {
      playlistsPage = 1;
      lockPlaylists.value = false;
      playlists.clear();
    }
    if (playlistsPage == 1) {
      // if (fromSearch) {
      //   if (searchCtrl.text.length < 3) {
      //     Fluttertoast.showToast(msg: 'Enter atleast 3 characters!');
      //     return;
      //   }
      //   isLoadingMorePlaylists.value = true;
      // } else {
      isLoadingPlaylists.value = true;
      // }
      playlists.clear();
    } else {
      isLoadingMorePlaylists.value = true;
    }
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(
      Urls.globalPlaylists(searchCtrl.text, page: playlistsPage.toString()),
    );
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoadingPlaylists.value = false;
        isLoadingMorePlaylists.value = false;
      },
      (result) {
        log(result.toString());
        try {
          result['data'].forEach((element) {
            playlists.add(PlayListModel.fromJson(element));
          });
        } catch (_) {}
        if (playlistsPage == 1) {
          playlistsPage += 1;
          isLoadingPlaylists.value = false;
        } else {
          if (result['data'].length > 0) {
            playlistsPage += 1;
          } else {
            lockPlaylists.value = true;
          }
          isLoadingMorePlaylists.value = false;
        }
      },
    );
  }
}
