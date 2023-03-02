import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/details.dart';

class PostOverviewWidget extends StatefulWidget {
  const PostOverviewWidget({
    Key? key,
    required this.post,
    this.detailsMaxLines,
    this.videoController,
    required this.reportFunction,
    required this.likeFunction,
  }) : super(key: key);

  final PostDetailsModel post;
  final int? detailsMaxLines;
  final BetterPlayerController? videoController;
  final Function reportFunction;
  final Function likeFunction;

  @override
  State<PostOverviewWidget> createState() => _PostOverviewWidgetState();
}

class _PostOverviewWidgetState extends State<PostOverviewWidget> {
  late bool isLiked;
  @override
  void initState() {
    isLiked = widget.post.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.find<LiveVideoController>().stopLive(false);
        Get.toNamed(Routes.postDetails, arguments: widget.post);
      },
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 25),
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.post.userImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, _, __) => Image.asset(
                        'assets/Images/userplaceholder.png',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        // Container(
                        //   padding: const EdgeInsets.only(
                        //     right: 10,
                        //     bottom: 3,
                        //     top: 3,
                        //   ),
                        //   decoration: const BoxDecoration(
                        //     border: Border(
                        //       bottom: BorderSide(
                        //         color: Colors.white,
                        //         width: .25,
                        //       ),
                        //     ),
                        //   ),
                        //   child: Text(
                        //     widget.post.userEmail,
                        //     style: const TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 10,
                        //     ),
                        //   ),
                        // ),
                        Text(
                          widget.post.date,
                          style: const TextStyle(
                            color: Color(0XFF838383),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.post.details,
              maxLines: widget.detailsMaxLines,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Color(0XFFF2F2F2),
                fontFamily: 'cairo',
              ),
            ),
          ),
          !widget.post.isVideo
              ? Container(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.network(
                    widget.post.url,
                    height: (Get.size.width) - 40,
                    width: (Get.size.width) - 40,
                    fit: BoxFit.contain,
                    loadingBuilder: (ctx, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Skeleton(
                          width: (Get.size.width) - 40,
                          height: (Get.size.width) - 40,
                          padding: 0,
                          borderRadius: BorderRadius.circular(5),
                        );
                      }
                    },
                    errorBuilder: (ctx, _, __) => Container(),
                  ),
                )
              : widget.videoController != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: BetterPlayer(
                          controller: widget.videoController!,
                        ),
                      ),
                    )
                  : ClipRRect(
                      child: Stack(
                        children: [
                          Image.network(
                            widget.post.image,
                            height: (Get.size.width) / 2,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (ctx, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Skeleton(
                                  height: (Get.size.width) / 2,
                                  width: double.infinity,
                                  padding: 0,
                                  borderRadius: BorderRadius.circular(5),
                                );
                              }
                            },
                            errorBuilder: (ctx, _, __) => Container(),
                          ),
                          Positioned(
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: const Icon(
                                FlutterIcons.play_1,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (Get.find<AppSession>().token.isEmpty) {
                      Fluttertoast.showToast(
                          msg:
                              'Please login to your account to like this post');
                    } else {
                      if (!isLiked) {
                        setState(() {
                          isLiked = true;
                        });
                        widget.likeFunction();
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? FlutterIcons.heart : FlutterIcons.heart_empty,
                        color: Colors.white,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          widget.post.totalLike.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '''total
likes''',
                  style: TextStyle(
                    color: Color(0XFFB5B5B5),
                    fontSize: 11,
                    height: .8,
                  ),
                ),
                const SizedBox(width: 45),
                const Icon(
                  FlutterIcons.nojoom_reply,
                  color: Colors.white,
                  size: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    widget.post.totalReplay.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
                const Text(
                  '''total
replyes''',
                  style: TextStyle(
                    color: Color(0XFFB5B5B5),
                    fontSize: 11,
                    height: .8,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () => widget.reportFunction(),
                    child: const Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
