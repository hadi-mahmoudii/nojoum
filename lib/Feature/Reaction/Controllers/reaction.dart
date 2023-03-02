import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class ReactionController extends GetxController {
  ReactionController();

  report(final String id, final String type) async {
    if (Get.find<AppSession>().token.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please login to your account to report this post');
      return;
    }
    Get.defaultDialog(
      backgroundColor: Colors.black54,
      title: 'report',
      middleText: 'Are you sure report this $type?',
      actions: [
        TextButton(
          onPressed: () async {
            Get.back();
            Fluttertoast.showToast(msg: 'This $type reported successfully');
            final Either<ErrorResult, dynamic> result =
                await ServerRequest().sendData(
              Urls.report,
              datas: {
                'report': 'report',
                'reportable_id': id,
                'reportable_type': type,
              },
            );
            result.fold(
              (error) async {},
              (result) {
                log(result.toString());
              },
            );
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  like(final String id, final String type) async {
    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.like,
      datas: {
        'likable_id': id,
        'likable_type': type,
      },
    );
    result.fold(
      (error) async {},
      (result) {
        log(result.toString());
      },
    );
  }
}
