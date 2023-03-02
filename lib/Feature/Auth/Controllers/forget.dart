// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class ForgetPassController extends GetxController {
  var isLoading = false.obs;
  var codeSended = false.obs;
  var verifyComplated = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController codeCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController rePasswordCtrl = TextEditingController();
  // TextEditingController passwordCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late String tempToken;

  forgetPassRequest(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.forgetPass,
      datas: {
        'email': emailCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading.value = false;
        //notifyListeners();
        Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) {
        log(result.toString());

        //notifyListeners();
        try {
          if (result['errors']['email'][0] ==
              'The selected email is invalid.') {
            Fluttertoast.showToast(msg: 'Your email not found!');
            isLoading.value = false;
            return;
          }
        } catch (e) {}
        codeSended.value = true;
        isLoading.value = false;
        // try {
        //   if (result['errors']['email'][0] ==
        //       'The email must be a valid email address.') {
        //     isLoading = false;
        //     //notifyListeners();
        //     Fluttertoast.showToast(
        //         msg: 'The email must be a valid email address.');
        //     return;
        //   }
        // } catch (e) {}
      },
    );
  }

  forgetPassVerify(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.forgetPassVerify,
      datas: {
        'email': emailCtrl.text,
        'code': codeCtrl.text,
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading.value = false;
        //notifyListeners();
        Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) {
        log(result.toString());
        try {
          if (result['errors']['code'] == 'messages.invalid_code') {
            isLoading.value = false;
            //notifyListeners();
            Fluttertoast.showToast(msg: 'Code is wrong!');
            return;
          }
        } catch (e) {}
        tempToken = 'Bearer ' + result['data']['token'];
        verifyComplated.value = true;
        isLoading.value = false;
        //notifyListeners();
        // try {
        //   if (result['message']['title'] == 'Success') {
        //     Fluttertoast.showToast(msg: 'New password to your email.');
        //     Get.back();
        //     return;
        //   }
        // } catch (e) {}
        // try {
        //   if (result['errors']['email'][0] ==
        //       'The email must be a valid email address.') {
        //     isLoading = false;
        //     //notifyListeners();
        //     Fluttertoast.showToast(
        //         msg: 'The email must be a valid email address.');
        //     return;
        //   }
        // } catch (e) {}
      },
    );
  }

  changePassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    //notifyListeners();
    final Either<ErrorResult, dynamic> result =
        await ServerRequest().sendData(Urls.forgetChangePass, datas: {
      'password': passwordCtrl.text,
      'password_confirmation': rePasswordCtrl.text,
    }, headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': tempToken,
      "Content-Type": "application/json",
      "Accept": "application/json",
      'accept-language': 'en',
    });
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
        isLoading.value = false;
        //notifyListeners();
        Fluttertoast.showToast(msg: 'The email must be a valid email address.');
      },
      (result) {
        try {
          if (result['is_success']) {
            Fluttertoast.showToast(msg: 'Password changed.');
            Get.back();
            return;
          }
        } catch (e) {}
        codeSended.value = true;
        isLoading.value = false;
      },
    );
  }
}
