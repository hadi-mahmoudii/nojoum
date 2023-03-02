import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/urls.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../Model/comment.dart';

class CommentController extends GetxController
    with StateMixin<List<CommentModel>> {
  // var isLoading = false.obs;
  var isLoadingMore = false.obs;

  TextEditingController commentCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  int currentPage = 1;
  var lockPage = false.obs;
  final String type;
  final String id;
  List<CommentModel> comments = [];

  CommentController(this.type, this.id);

  getComments({bool resetPage = false}) async {
    // if (resetPage) {
    comments.clear();
    currentPage = 1;
    // }

    change([], status: RxStatus.loading());

    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(Urls.getComments(id, type));
    // await ServerRequest().fetchData(Urls.getComments('1', 'news'));

    result2.fold(
      (error) async {
        change([], status: RxStatus.error());
      },
      (result) {
        // log(Urls.getComments(id, type));
        // log(result.toString());
        // print(result);
        try {
          result['data'].forEach((element) {
            // print(element);
            comments.add(CommentModel.fromJson(element));
            // print(result['children']);
          });
        } catch (_) {}

        change(comments, status: RxStatus.success());
        //notifyListeners();
      },
    );
  }

  addComment(
      {final String parentId = '', final Function? onEndFunction}) async {
    if (Get.find<AppSession>().token.isEmpty) {
      Fluttertoast.showToast(msg: 'Please do login for send comment!');
      return;
    }

    if (commentCtrl.text.length < 3) {
      Fluttertoast.showToast(msg: 'Enter atleast 3 characters!');
      return;
    }

    // isLoading.value = true;

    String url = Urls.sendComment(id, type);
    if (parentId.isNotEmpty) url += '&parent_id=$parentId';
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().sendData(url, datas: {
      'message': commentCtrl.text,
    });
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        // isLoading.value = false;
        //notifyListeners();
      },
      (result) {
        // log(result.toString());
        // isLoading.value = false;
        commentCtrl.text = '';
        // Fluttertoast.showToast(msg: 'Your comment will publish after review.');
        Get.back();
        if (onEndFunction != null) {
          onEndFunction();
        }
        //notifyListeners();
      },
    );
  }

  Future showCommentDialog({
    final String title = 'NEW COMMENT',
    final String buttonComment = 'ADD COMMENT',
    final String parentId = '',
    final Function? onEndFunction,
  }) async {
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        height: 300,
        color: Colors.black,
        child: ListView(
          children: [
            SimpleHeader(
              mainHeader: title,
              angleFuncion: () => Get.back(),
              showRightAngle: true,
              angleIcon: FlutterIcons.cancel_linear,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: InputBox(
                label: 'COMMENT TEXT',
                controller: commentCtrl,
                minLines: 5,
                maxLines: 7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubmitButton2(
                func: () => addComment(
                    parentId: parentId, onEndFunction: onEndFunction),
                icon: null,
                title: buttonComment,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void onReady() {
  //   getComments();
  //   super.onReady();
  // }
}
