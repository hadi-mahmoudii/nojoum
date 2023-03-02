import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Feature/Comment/Model/comment.dart';

class CommentBox extends StatefulWidget {
  const CommentBox({
    Key? key,
    required this.comment,
    this.isLikeable = false,
    this.isReplayable = false,
    this.replayFunction,
  }) : super(key: key);
  final CommentModel comment;
  final bool isLikeable;
  final bool isReplayable;
  final Function? replayFunction;

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.comment.user,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                FlutterIcons.clock,
                color: const Color(0XFFD8D8D8).withOpacity(.5),
                size: 11,
              ),
              Text(
                widget.comment.date,
                style: const TextStyle(
                  color: Color(0XFFD8D8D8),
                  fontFamily: 'montserratlight',
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (widget.replayFunction != null) {
                    widget.replayFunction!();
                  }
                },
                child: const Icon(
                  Icons.replay,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.comment.comment,
            style: const TextStyle(
              color: Color(0XFFC7C7C7),
              fontSize: 12,
              fontFamily: 'montserratlight',
            ),
          ),
          widget.comment.childComments.isNotEmpty
              ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      margin: EdgeInsets.only(
                          top: 30, left: Get.size.width / 5, bottom: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: .15,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.comment.childComments.length} REPLIES',
                            style: const TextStyle(
                                fontSize: 18, color: Color(0XFFE2E2E2)),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    isExpanded
                        ? Container(
                            margin: EdgeInsets.only(
                                left: Get.size.width / 5, bottom: 10),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.comment.childComments[index]
                                              .user,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        FlutterIcons.clock,
                                        color: const Color(0XFFD8D8D8)
                                            .withOpacity(.5),
                                        size: 9,
                                      ),
                                      Text(
                                        widget
                                            .comment.childComments[index].date,
                                        style: const TextStyle(
                                          color: Color(0XFFD8D8D8),
                                          fontFamily: 'montserratlight',
                                          fontSize: 9,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.comment.childComments[index].comment,
                                    style: const TextStyle(
                                      color: Color(0XFFC7C7C7),
                                      fontSize: 10,
                                      fontFamily: 'montserratlight',
                                    ),
                                  ),
                                ],
                              ),
                              separatorBuilder: (ctx, index) => const Divider(
                                height: 30,
                                color: Colors.white60,
                                thickness: .5,
                              ),
                              itemCount: widget.comment.childComments.length,
                            ),
                          )
                        : Container()
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
