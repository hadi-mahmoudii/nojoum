import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Music/Model/playlist.dart';

class PlaylistListController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();

  int currentPage = 1;
  var lockPage = false.obs;

  RxList<PlayListModel> playlists = RxList(<PlayListModel>[]);
  List<OptionModel> categories = [];
  // List<MyCustomProgramOverviewModel> myCustomPrograms = [];
  @override
  void onInit() async {
    await getPlaylists();
    super.onInit();
  }

  getPlaylists({bool resetPage = false, bool fromSearch = false}) async {
    if (resetPage || fromSearch) {
      currentPage = 1;
      playlists.clear();
      lockPage.value = false;
    }
    if (lockPage.value) return;
    if (currentPage == 1) {
      // if (fromSearch) {
      // if (searchCtrl.text.length < 3) {
      //   Fluttertoast.showToast(msg: 'Enter atleast 3 characters!');
      //   return;
      // }
      isLoading.value = true;
      // } else {
      //   isLoading.value = true;
      // }
    } else {
      isLoadingMore.value = true;
    }
    // print(Urls.globalPlaylists(
    //   searchCtrl.text,
    //   page: currentPage.toString(),
    // ));
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(
      Urls.globalPlaylists(
        searchCtrl.text,
        page: currentPage.toString(),
      ),
    );
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // log(result.toString());
        try {
          result['data'].forEach((element) {
            playlists.add(PlayListModel.fromJson(element));
          });

          if (currentPage == 1) {
            currentPage += 1;
            isLoading.value = false;
          } else {
            if (result['data'].length > 0) {
              currentPage += 1;
            } else {
              lockPage.value = true;
            }
            isLoadingMore.value = false;
          }
        } catch (_) {}
      },
    );
  }
}
