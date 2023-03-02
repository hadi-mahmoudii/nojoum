// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class ChangePassController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController curPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController reNewPass = TextEditingController();

  var formKey = GlobalKey<FormState>();

  changePassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    // notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.changePass,
      datas: {
        'old_password': curPass.text,
        'password': newPass.text,
        'password_confirmation': reNewPass.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        log(result.toString());
        try {
          if (result['message']['title'] == 'messages.success_title') {
            Fluttertoast.showToast(msg: 'Your password changed');
            Get.back();
            return;
          }
        } catch (e) {}
        try {
          if (result['errors']['old_password'][0] ==
              'The password is incorrect.') {
            Fluttertoast.showToast(msg: 'Your old password is wrong!');
            isLoading.value = false;
            return;
          }
        } catch (e) {}
        isLoading.value = false;
        // notifyListeners();
        Fluttertoast.showToast(msg: 'Error change password!');
      },
    );
  }
}
