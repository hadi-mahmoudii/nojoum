import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Models/option_model.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../Model/music.dart';

class MusicRowController extends GetxController {
  var isLoading = false.obs;
  var isMyFavorite = false.obs;
  changeFavorite() {
    isMyFavorite.value = !isMyFavorite.value;
    if (isMyFavorite.value) {
      Fluttertoast.showToast(msg: 'Added to favorites');
    } else {
      Fluttertoast.showToast(msg: 'Removed to favorites');
    }
  }

  TextEditingController textCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  // var playlists = [].obs;

  final MusicModel music;

  MusicRowController(this.music);
  @override
  void onInit() async {
    isMyFavorite.value = music.isFavorite;
    super.onInit();
  }

  Future<List<OptionModel>> getPlaylists() async {
    Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.myPlaylists,
    );
    List<OptionModel> playlists = [];
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // print(result);
        try {
          result['data'].forEach((element) {
            playlists.add(OptionModel(
                id: element['id'].toString(), title: element['name']));
          });
        } catch (_) {}
      },
    );
    return playlists;
  }
}
