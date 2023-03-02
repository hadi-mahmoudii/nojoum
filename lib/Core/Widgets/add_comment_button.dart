import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Models/server_request.dart';
import 'error_result.dart';
import 'filter.dart';
import 'input_box.dart';
import 'loading.dart';
import 'simple_header.dart';
import 'submit_button.dart';

class AddNewCommentButton extends StatefulWidget {
  const AddNewCommentButton({
    Key? key,
    required this.themeData,
    required this.contx,
    required this.id,
    required this.type,
  }) : super(key: key);
  final TextTheme themeData;
  final BuildContext contx;
  final String id, type;

  @override
  State<AddNewCommentButton> createState() => _AddNewCommentButtonState();
}

class _AddNewCommentButtonState extends State<AddNewCommentButton> {
  final TextEditingController commentCtrl = TextEditingController();
  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(widget.contx).size.height / 2),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(widget.contx).viewInsets.bottom),
          child: FilterWidget(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: isSending
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SimpleHeader(
                            mainHeader: 'ADD COMMENT',
                          ),
                          const SizedBox(height: 20),
                          InputBox(
                            label: 'Comment',
                            controller: commentCtrl,
                            minLines: 4,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 20),
                          SubmitButton(
                            func: () async {
                              setState(() {
                                isSending = true;
                              });
                              final Either<ErrorResult, dynamic> result =
                                  await ServerRequest().sendData(
                                'Urls.sendComment',
                                datas: {
                                  'commentable_type': widget.type,
                                  'commentable_id': widget.id,
                                  'comment': commentCtrl.text,
                                },
                              );
                              result.fold(
                                (error) async {
                                  await ErrorResult.showDlg(
                                      error.type!, context);
                                },
                                (result) async {
                                  Fluttertoast.showToast(msg: 'Done');
                                  Get.back();
                                },
                              );
                            },
                            icon: Icons.add,
                            title: 'Send',
                          )
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white54),
            bottom: BorderSide(color: Colors.white54),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 13,
            ),
            const SizedBox(width: 10),
            Text(
              'ADD NEW COMMENT',
              style: widget.themeData.overline!.copyWith(
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
