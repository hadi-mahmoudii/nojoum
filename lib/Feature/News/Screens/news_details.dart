import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/empty2.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Comment/Widget/comment_box.dart';
import '../../Comment/Widget/comment_header.dart';
import '../Controllers/news_details.dart';
import '../Widgets/news_box.dart';

class NewsDetailsScreen extends GetView<NewsDetailsController> {
  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          bottomNavigationBar: const MiniMusicPlayerBox(),
          appBar: GlobalAppbar(
            subtitle: 'know more',
            title: 'News details',
            textTheme: themeData,
          ).build(context),
          body: FilterWidget(
            child: controller.isLoading.value
                ? const Center(
                    child: LoadingWidget(),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        ClipRRect(
                          // borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            controller.news.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            loadingBuilder: (ctx, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Skeleton(
                                  height: 200,
                                  width: double.maxFinite,
                                  padding: 0,
                                  borderRadius: BorderRadius.circular(5),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/Images/newsplaceholder.png',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.news.name,
                          textAlign: TextAlign.end,
                          // textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'cairo',
                          ),
                        ),
                        const SizedBox(height: 5),
                        controller.news.date.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    FlutterIcons.clock,
                                    color: Colors.white.withOpacity(.5),
                                    size: 11,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    controller.news.date,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'montserratlight',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        Text(
                          controller.news.description,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0XFFE0E0E0),
                            fontFamily: 'cairo',
                          ),
                        ),
                        Obx(
                          () => controller.haveVideo.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 30),
                                  child: AspectRatio(
                                    aspectRatio: 2,
                                    child: BetterPlayer(
                                      controller: controller.controller,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        controller.similarNews.isNotEmpty
                            ? ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 40, bottom: 10),
                                    child: SimpleHeader(
                                      mainHeader: 'SIMILAR NEWS',
                                      letPadding: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    // width: 500,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, ind) => SizedBox(
                                        // height: 250,
                                        width: Get.size.width * 4 / 10,
                                        child: NewsNavigatorBox(
                                            themeData: themeData,
                                            news: controller.similarNews[ind]),
                                      ),
                                      separatorBuilder: (ctx, ind) =>
                                          const SizedBox(width: 15),
                                      itemCount: controller.similarNews.length,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(height: 40),
                        CommentHeader(
                          angleFuncion: () => Get.find<AppSession>()
                                  .token
                                  .isNotEmpty
                              ? controller.commentProvider.showCommentDialog(
                                  onEndFunction: () {
                                    controller.commentProvider.getComments();
                                  },
                                )
                              : Fluttertoast.showToast(
                                  msg: 'Please do login for send comment!'),
                        ),
                        controller.commentProvider.obx(
                          (comments) => ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: controller.scrollCtrl,
                            itemBuilder: (ctx, ind) =>
                                CommentBox(comment: comments![ind]),
                            separatorBuilder: (ctx, ind) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                color: Colors.white,
                                height: 30,
                                thickness: .2,
                              ),
                            ),
                            itemCount: comments!.length,
                          ),
                          onLoading: const LoadingWidget(),
                          onEmpty: const Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: EmptyBox2(
                              icon: FlutterIcons.chat_1,
                              topHeight: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
