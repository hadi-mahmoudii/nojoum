// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../../Music/Model/playlist.dart';

class MyPlaylistsController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController categoryCtrl = TextEditingController();

  int currentPage = 1;

  List<PlayListModel> playlists = [];
  List<OptionModel> categories = [];
  // List<MyCustomProgramOverviewModel> myCustomPrograms = [];
  @override
  void onInit() async {
    await getPlaylists();
    super.onInit();
  }

  getCategories() async {
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.categories);
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // log(result.toString());
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          categories.add(OptionModel(
              id: element['id'].toString(),
              title: element['name_ar'] ?? element['name']));
          // print(result['children']);
        });
        // isLoading = false;
        // notifyListeners();
      },
    );
  }

  getPlaylists({bool resetPage = false}) async {
    if (resetPage) {
      playlists = [];
    }
    isLoading.value = true;
    await getCategories();

    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.myPlaylists);
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // print(result);
        result['data'].forEach((element) {
          // print(element);
          playlists.add(PlayListModel.fromJson(element));
          // print(result['children']);
        });
        isLoading.value = false;
      },
    );
  }

  add(BuildContext context) async {
    if (nameCtrl.text.isEmpty || categoryCtrl.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Fill all fields!');
      return;
    }
    isLoading.value = true;

    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.addUserPlaylist,
      datas: {
        'name': nameCtrl.text,
        'genre_id': categories
            .firstWhere((element) => element.title == categoryCtrl.text)
            .id,
        // 'last_name': lNameCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        log(result.toString());
        try {
          if (result['data']['id'] != '') {
            Fluttertoast.showToast(msg: 'Playlist created.');
            Get.back();
            await getPlaylists();
            return;
          }
        } catch (e) {}
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Error!');
      },
    );
  }

  delete(BuildContext context, String id) async {
    isLoading.value = true;

    final Either<ErrorResult, dynamic> result =
        await ServerRequest().deleteData(Urls.deletePlaylist(id));
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        log(result.toString());
        // try {
        //   if (result['data']['message']['title'] == 'messages.success_title') {
        //     Fluttertoast.showToast(msg: 'Playlist deleted.');
        //     playlists.removeWhere((element) => element.id == id);
        //     isLoading.value = false;
        //     return;
        //   }
        // } catch (e) {}
        try {
          playlists.removeWhere((element) => element.id == id);
          Fluttertoast.showToast(msg: 'Playlist deleted.');
        } catch (e) {}
        isLoading.value = false;
      },
    );
  }

  addDialog(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        height: 400,
        margin: EdgeInsets.only(
          bottom: Get.mediaQuery.viewInsets.bottom,
        ),
        child: FilterWidget(
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const SimpleHeader(
                mainHeader: 'ADD A PLAYLIST',
                subHeader: '',
                showRightAngle: false,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InputBox(
                      label: 'PLAYLIST NAME',
                      controller: nameCtrl,
                    ),
                    const SizedBox(height: 20),
                    StaticBottomSelector(
                      label: 'CATEGORY',
                      controller: categoryCtrl,
                      datas: categories,
                      itemsAlignment: Alignment.centerRight,
                    ),
                    const SizedBox(height: 25),
                    SubmitButton(
                      func: () => add(context),
                      icon: null,
                      title: 'ADD THE PLAYLIST',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
