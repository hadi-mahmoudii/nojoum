import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/app_session.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/empty.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Core/main_screen.dart';
import 'package:nojoum/Feature/General/Widget/top_live_banner.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';
import 'package:nojoum/Feature/Post/Controllers/my_feed.dart';
import 'package:nojoum/Feature/Post/Controllers/stories.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';

import '../../../Core/Widgets/mini_music_player.dart';
import '../Widgets/post_overview.dart';

class MyFeedScreen extends StatefulWidget {
  const MyFeedScreen({Key? key}) : super(key: key);

  @override
  State<MyFeedScreen> createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen>
    with AutomaticKeepAliveClientMixin<MyFeedScreen> {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<MyFeedController>();
  final musicController = Get.find<MusicDetailsController>();
  final liveController = Get.find<LiveVideoController>();
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 75),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 46, 45, 45),
          onPressed: () async {
            await liveController.stopLive(false);

            if (Get.find<AppSession>().token.isNotEmpty) {
              Get.toNamed(Routes.addPost);
            } else {
              Get.toNamed(Routes.login);
            }
          },
          child: const Icon(
            FlutterIcons.plus_linear,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 15),
            color: Colors.white,
            height: .25,
          ),
          preferredSize: const Size.fromHeight(.25),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              'NOJOUM',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const Spacer(),
          Visibility(
            visible: Get.find<AppSession>().headerImage.isNotEmpty,
            child: Image.network(
              Get.find<AppSession>().headerImage,
              width: 75,
              height: 75,
              errorBuilder: (_, __, ___) => Container(),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await liveController.stopLive(false);
              Get.toNamed(Routes.searchMedia);
            },
            icon: const Icon(
              FlutterIcons.search_1,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () async {
              await liveController.stopLive(false);
              try {
                //pause music if its playing
                if (musicController.hasValue.value) {
                  await musicController.audioPlayer.pause();
                }
              } catch (_) {}
              Get.toNamed(Routes.live)!.then((value) async {
                SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp],
                );
                try {
                  if (musicController.hasValue.value) {
                    await musicController.audioPlayer.play();
                  }
                } catch (_) {}
              });
            },
            icon: const Icon(
              FlutterIcons.mask_group_3,
              size: 30,
            ),
          ),
          const SizedBox(width: 5),
        ],
        centerTitle: false,
      ),
      body: FilterWidget(
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              if (controller.scrollCtrl.position.pixels >
                      controller.scrollCtrl.position.maxScrollExtent - 30 &&
                  controller.status != RxStatus.loadingMore() &&
                  !controller.lockPage.value) {
                controller.getPosts();
              }
            }
            return true;
          },
          child: Stack(
            children: [
              controller.obx(
                (posts) => RefreshIndicator(
                  onRefresh: () async {
                    await liveController.stopLive(true);
                    Get.find<StoriesController>().getStories(resetPage: true);
                    liveController.getLive(resetPage: true);
                    await controller.getPosts(resetPage: true);
                  },
                  child: SizedBox(
                    height: Get.size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // StoryHeaderBox(),
                        Obx(
                          () => SizedBox(
                              height: liveController.letShowLive.value &&
                                      !musicController.hasValue.value
                                  ? 210
                                  : 0),
                        ),
                        Expanded(
                          child: ListView(
                            controller: controller.scrollCtrl,
                            children: [
                              ListView.separated(
                                padding: const EdgeInsets.only(bottom: 150),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, ind) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: PostOverviewWidget(
                                    post: posts![ind],
                                    detailsMaxLines: 3,
                                    reportFunction: () => controller
                                        .reactionController
                                        .report(posts[ind].id, 'post'),
                                    likeFunction: () {
                                      posts[ind].totalLike += 1;
                                      controller.reactionController
                                          .like(posts[ind].id, 'post');
                                    },
                                  ),
                                ),
                                separatorBuilder: (ctx, ind) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: .1,
                                    height: 30,
                                  ),
                                ),
                                itemCount: posts!.length,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onLoading: const LoadingWidget(),
                onEmpty: const Center(
                  child: EmptyWidget(),
                ),
                onError: (error) => const Center(
                  child: Text(
                    'Error to get datas!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TopLiveBanner(
                liveController: liveController,
                musicController: musicController,
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GlobalBottomNavigationBar(),
              ),
              musicController.hasValue.value
                  ? const Positioned(
                      bottom: 75,
                      left: 0,
                      right: 0,
                      child: MiniMusicPlayerBox(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
