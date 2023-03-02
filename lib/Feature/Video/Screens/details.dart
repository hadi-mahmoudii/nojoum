import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/empty2.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../Comment/Controllers/comment.dart';
import '../../Comment/Widget/comment_box.dart';
import '../../General/Widget/singer_navigator_row.dart';
import '../Controllers/details.dart';
import '../Widgets/box_navigator.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({Key? key}) : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  late String videoId;
  late BetterPlayerController controller;

  @override
  initState() {
    videoId = Get.arguments;
    tabCtrl = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // Get.delete<VideoDetailsController>(tag: videoId);
    Get.delete<CommentController>();
    super.dispose();
  }

  final appSession = Get.find<AppSession>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    final VideoDetailsController provider = Get.put(
      VideoDetailsController(videoId),
      tag: videoId,
    );

    return Obx(
      () => SafeArea(
        child: provider.isLoading.value
            ? const Scaffold(
                body: FilterWidget(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),
              )
            : Scaffold(
                appBar: GlobalAppbar(
                  subtitle: 'WATCH THE VIDEO',
                  title: provider.video.name,
                  textTheme: themeData,
                ).build(context),
                body: FilterWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ChampyaHeader(),
                        // SizedBox(height: 15),
                        // AspectRatio(
                        //   aspectRatio: 2,
                        //   child: FlickVideoPlayer(
                        //     flickManager: provider.flickManager,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        AspectRatio(
                          aspectRatio: 2,
                          child: BetterPlayer(
                            controller: provider.controller,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.white, width: .7),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                provider.video.playCount,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '''times
watched''',
                                style:
                                    themeData.headline3!.copyWith(height: .95),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  Share.share('https://nojoum.app');
                                },
                                child: const Icon(
                                  FlutterIcons.whatsapp,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              appSession.token.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: InkWell(
                                        onTap: () {
                                          provider.changeFavorite(context);
                                        },
                                        child: Icon(
                                          provider.isMyFavorite.value
                                              ? FlutterIcons.heart
                                              : FlutterIcons.heart_empty,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        provider.video.artist.id.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SingerNavigatorRow(
                                  themeData: themeData,
                                  artist: provider.video.artist,
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 50),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TabBar(
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            unselectedLabelColor: const Color(0XFFA8A8A8),
                            controller: tabCtrl,
                            onTap: (index) {
                              setState(() {
                                currentTabIndex = index;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: 'NEXT VIDEOS',
                              ),
                              Tab(
                                text: 'COMMENTS',
                              ),
                            ],
                          ),
                        ),

                        Builder(builder: (_) {
                          if (currentTabIndex == 0) {
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 130 / 100,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (ctx, ind) =>
                                        VideoBoxNavigator(
                                      themeData: themeData,
                                      video: provider.nextVideoes[ind],
                                      letRestartLive: false,
                                      replaceRoute: true,
                                    ),
                                    itemCount: provider.nextVideoes.length,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 20),
                                //   child: SubmitButton(
                                //     func: () {},
                                //     icon: null,
                                //     title: 'See all',
                                //   ),
                                // ),
                              ],
                            ); //1st custom tabBarView
                          } else {
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                InkWell(
                                  onTap: () => provider.commentProvider
                                      .showCommentDialog(
                                    onEndFunction: () {
                                      provider.commentProvider.getComments();
                                    },
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.white54),
                                        bottom:
                                            BorderSide(color: Colors.white54),
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          FlutterIcons.plus_linear,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'NEW COMMENT',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: provider.commentProvider.obx(
                                    (comments) => ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, ind) =>
                                          CommentBox(comment: comments![ind]),
                                      separatorBuilder: (ctx, ind) =>
                                          const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Divider(
                                          color: Colors.white,
                                          height: 30,
                                          thickness: .2,
                                        ),
                                      ),
                                      itemCount: comments!.length,
                                    ),
                                    onEmpty: const Padding(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: EmptyBox2(
                                        icon: FlutterIcons.chat_1,
                                        topHeight: 100,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            ///2nd tabView
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
