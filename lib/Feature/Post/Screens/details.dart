import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/app_session.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/empty.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Core/Widgets/simple_header.dart';
import 'package:nojoum/Feature/Comment/Widget/comment_box.dart';
import 'package:nojoum/Feature/Post/Controllers/details.dart';
import 'package:nojoum/Feature/Post/Widgets/post_details_header.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/mini_music_player.dart';

class PostDetailsScreen extends GetView<PostDetailsController> {
  const PostDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MiniMusicPlayerBox(),
      appBar: GlobalAppbar(
        subtitle: '',
        title: 'Post Details',
        textTheme: Get.textTheme,
      ).build(context),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromARGB(255, 46, 45, 45),
        onPressed: () async {
          if (Get.find<AppSession>().token.isNotEmpty) {
            await controller.commentController.showCommentDialog(
              title: 'NEW REPLY',
              buttonComment: 'ADD',
              onEndFunction: () {
                controller.commentController.getComments();
              },
            );
          } else {
            Get.toNamed(Routes.login);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FlutterIcons.plus_linear,
                size: 20,
                color: Colors.white,
              ),
              SizedBox(height: 1),
              Text(
                'REPLY',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FilterWidget(
        child: controller.obx(
          (post) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                PostDetailsHeader(
                  post: post!,
                  videoController: controller.videoController,
                  reportFunction: () => controller.reactionController.report(
                    post.id,
                    'post',
                  ),
                  likeFunction: () {
                    post.totalLike += 1;
                    controller.reactionController.like(post.id, 'post');
                  },
                ),
                const Divider(
                  color: Colors.white54,
                  height: 10,
                ),
                const SizedBox(height: 20),
                const SimpleHeader(mainHeader: 'REPLIES', letPadding: false),
                controller.commentController.obx(
                    (comments) => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) => CommentBox(
                            comment: comments![index],
                            isLikeable: true,
                            isReplayable: true,
                            replayFunction: () async {
                              await controller.commentController
                                  .showCommentDialog(
                                title: 'NEW REPLY',
                                buttonComment: 'ADD',
                                parentId: controller
                                    .commentController.comments[index].id,
                                onEndFunction: () {
                                  controller.commentController.getComments();
                                },
                              );
                            },
                          ),
                          separatorBuilder: (ctx, index) =>
                              const SizedBox(height: 10),
                          itemCount: comments!.length,
                        ),
                    onLoading: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: LoadingWidget(),
                    )),
                const SizedBox(height: 50),
              ],
            ),
          ),
          onLoading: const LoadingWidget(),
          onEmpty: const Center(
            child: EmptyWidget(),
          ),
          onError: (error) => Center(child: Text(error!)),
        ),
      ),
    );
  }
}
