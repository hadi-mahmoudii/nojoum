import 'dart:convert';
import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../Post/Controllers/explore.dart';
import '../../Post/Controllers/my_feed.dart';

class SubmitCodeController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController codeCtrl = TextEditingController();
  // TextEditingController passwordCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final String email;

  SubmitCodeController(this.email);

  submitCode(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.submitCode,
      datas: {
        'code': codeCtrl.text,
        'email': email,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading.value = false;
        //notifyListeners();
        // Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) async {
        log(result.toString());
        try {
          if (result['errors']['code'] == 'messages.invalid_code') {
            isLoading.value = false;
            //notifyListeners();
            Fluttertoast.showToast(msg: 'Code is wrong!');
            return;
          }
        } catch (_) {}
        try {
          if (result['token'] != '') {
            // Get.toNamed(Routes.submitCode, arguments: email);
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
        isLoading.value = false;
      },
    );
  }
}
