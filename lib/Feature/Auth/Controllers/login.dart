import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nojoum/Feature/Post/Controllers/explore.dart';
import 'package:nojoum/Feature/Post/Controllers/my_feed.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  login(BuildContext context) async {
    // print(emailCtrl.text);
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.login,
      datas: {
        'username': emailCtrl.text,
        'password': passwordCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading.value = false;
      },
      (result) async {
        log(result.toString());
        try {
          if (result['data']['token'] != '') {
            var appSession = Get.find<AppSession>();
            appSession.setToken('Bearer ' + result['data']['token']);
            appSession.setImage(result['data']['user']['thumbnail']);
            String username = '';
            try {
              username = result['data']['user']['first_name'];
              appSession.setUserName(username);
            } catch (_) {}
            final prefs = GetStorage();

            // final prefs = await SharedPreferences.getInstance();
            final userData = json.encode({
              'token': appSession.token,
              'username': username,
              'image': appSession.image,
            });
            prefs.write('userData', userData);
            Get.find<AppSession>().changePage(0);
            Get.delete<MyFeedController>();
            Get.delete<ExploreController>();
            Get.offAllNamed(Routes.mainScreen);
            // try {
            //   Get.find<LiveVideoController>().changeLiveStatus(false);
            // } catch (e) {}
            return;
          }
        } catch (_) {}
        try {
          if (result['errors']['error'] ==
              'These credentials do not match our records.') {
            isLoading.value = false;
            //notifyListeners();
            Fluttertoast.showToast(msg: 'Username or password are wrong!');
            return;
          }
        } catch (_) {}
        Fluttertoast.showToast(msg: 'Username or password are wrong!');
        isLoading.value = false;
        //notifyListeners();
      },
    );
  }
}
