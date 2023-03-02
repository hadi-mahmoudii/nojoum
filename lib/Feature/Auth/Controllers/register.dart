// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();

  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController rePasswordCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();

  register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.register,
      datas: {
        'first_name': fNameCtrl.text,
        'last_name': lNameCtrl.text,
        'email': emailCtrl.text,
        'password': passwordCtrl.text,
        'password_confirmation': rePasswordCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        log(result.toString());
        try {
          if (result['is_success']) {
            Get.offNamed(Routes.submitCode, arguments: emailCtrl.text);
            // Navigator.of(context).pushReplacementNamed(Routes.submitCode,
            //     arguments: emailCtrl.text);
            return;
            // AppSession.token = 'Bearer ' + result['token'];
            // final prefs = await SharedPreferences.getInstance();
            // final userData = json.encode({
            //   'token': AppSession.token,
            // });
            // prefs.setString('userData', userData);
            // Get.back();
            // Navigator.of(context).pushReplacementNamed(Routes.MainScreen);
            // return;
          }
        } catch (e) {}
        try {
          if (result['errors']['email'][0] ==
              'The email has already been taken.') {
            isLoading.value = false;
            //notifyListeners();
            Fluttertoast.showToast(msg: 'The email has already been taken.');
            return;
          }
        } catch (e) {}
      },
    );
  }
}
