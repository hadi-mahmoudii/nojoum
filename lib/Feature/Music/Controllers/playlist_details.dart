import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Profile/Controllers/my_playlists.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Model/music.dart';
import '../Model/playlist.dart';

class PlaylistDetailsController extends GetxController {
  var isLoading = true.obs;
  var isLoadingMore = false.obs;

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  late String playlistId;
  late bool isMyPlaylist; //this field use for delete ability
  PlaylistDetailsController();
  List<MusicModel> musics = [];
  late PlayListModel playlist;

  fetchData() async {
    playlistId = Get.arguments[0] as String;
    isMyPlaylist = Get.arguments[1] as bool;
    isLoading.value = true;
    final Either<ErrorResult, dynamic> result3 =
        await ServerRequest().fetchData(
      Urls.getPlaylist(playlistId),
    );
    result3.fold(
      (error) async {
        isLoading.value = false;
      },
      (result) {
        log(result.toString());
        try {
          playlist = PlayListModel.fromJson(result['data']);
          for (var element in playlist.musics) {
            musics.add(element);
          }
          isLoading.value = false;
        } catch (e) {
          Fluttertoast.showToast(msg: 'Error fetch datas');
          isLoading.value = false;
          Get.back();
        }
      },
    );
  }

  removeFromPlayList(String musicId) async {
    isLoading.value = true;
    //notifyListeners();
    // isMyFavorite = !isMyFavorite;
    // //notifyListeners();
    // print(Urls.deattachFromPlaylist(musicId));
    // print(musicId);
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.deattachFromPlaylist(playlist.id),
      datas: {
        'music_id': musicId,
      },
    );
    result.fold(
      (error) async {
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Error remove this song from playlist!');
      },
      (result) async {
        log(result.toString());
        Fluttertoast.showToast(msg: 'This song removed from your playlist.');
        musics.removeWhere((element) => element.id == musicId);
        Get.find<MyPlaylistsController>().getPlaylists(resetPage: true);
        isLoading.value = false;
      },
    );
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  // fetchDatas(BuildContext context,
  //     {bool resetPage = false, bool resetFilter = false}) async {
  //   if (resetPage) {
  //     currentPage = 1;
  //     lockPage = false;
  //     datas.clear();
  //   }
  //   if (lockPage) return;
  //   if (currentPage == 1) {
  //     // blogs = [];
  //     isLoading = true;
  //     notifyListeners();
  //   } else {
  //     isLoadingMore = true;
  //     notifyListeners();
  //   }
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.getMusics,
  //   );
  //   result.fold(
  //     (error) async {
  //       // await ErrorResult.showDlg(error.type, context);
  //       isLoading = false;
  //       notifyListeners();
  //     },
  //     (result) {
  //       // print(result);
  //       result['data'].forEach((element) {
  //         datas.add(MusicModel.fromJson(element));
  //       });
  //       if (currentPage == 1) {
  //         currentPage += 1;
  //         isLoading = false;
  //         notifyListeners();
  //       } else {
  //         if (result['data'].length > 0) {
  //           currentPage += 1;
  //         } else {
  //           lockPage = true;
  //         }
  //         isLoadingMore = false;
  //         notifyListeners();
  //       }
  //     },
  //   );
  // }

}
