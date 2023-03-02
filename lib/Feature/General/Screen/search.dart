import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Feature/General/Controllers/search.dart';

import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Music/Widget/playlist_box.dart';
import '../../Video/Widgets/box_navigator.dart';
import '../Widget/home_music_card.dart';

class SearchMediaScreen extends StatefulWidget {
  const SearchMediaScreen({Key? key}) : super(key: key);

  @override
  State<SearchMediaScreen> createState() => _SearchMediaScreenState();
}

class _SearchMediaScreenState extends State<SearchMediaScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(SearchMediaController());

  @override
  initState() {
    super.initState();
    controller.tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MiniMusicPlayerBox(),
      body: FilterWidget(
        child: SizedBox(
          height: Get.size.height,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SimpleHeader(
                mainHeader: 'Search',
                showRightAngle: false,
              ),

              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InputBox(
                        label: 'What do you looking for?',
                        controller: controller.searchCtrl,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (controller.currentTabIndex.value == 0) {
                          controller.getMusics(resetPage: true);
                        } else if (controller.currentTabIndex.value == 1) {
                          controller.getVideos(resetPage: true);
                        } else {
                          controller.getPlaylists(resetPage: true);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          FlutterIcons.search_1,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: const Color(0XFFA8A8A8),
                  controller: controller.tabCtrl,
                  onTap: controller.changeTabIndex,
                  tabs: const [
                    Tab(
                      text: 'MUSIC',
                    ),
                    Tab(
                      text: 'VIDEO',
                    ),
                    Tab(
                      text: 'PLAYLIST',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Builder(
                  builder: (_) {
                    return Obx(() {
                      if (controller.currentTabIndex.value == 0) {
                        return Obx(() => !controller.isLoadingMusics.value
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: NotificationListener(
                                  onNotification:
                                      (ScrollNotification notification) {
                                    if (notification
                                        is ScrollUpdateNotification) {
                                      if (controller.musicScrollCtrl.position
                                                  .pixels >
                                              controller
                                                      .musicScrollCtrl
                                                      .position
                                                      .maxScrollExtent -
                                                  30 &&
                                          !controller
                                              .isLoadingMoreMusics.value &&
                                          !controller.lockMusics.value) {
                                        controller.getMusics();
                                      }
                                    }
                                    return true;
                                  },
                                  child: GridView.builder(
                                    // shrinkWrap: true,
                                    controller: controller.musicScrollCtrl,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: .8,
                                      crossAxisSpacing: 7,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (ctx, ind) =>
                                        HomeMusicBoxNavigator(
                                      themeData: Get.textTheme,
                                      music: controller.musics[ind],
                                    ),
                                    itemCount: controller.musics.length,
                                  ),
                                ),
                              )
                            : const Center(child: LoadingWidget()));
                      }
                      if (controller.currentTabIndex.value == 1) {
                        return Obx(() => !controller.isLoadingVideos.value
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: NotificationListener(
                                  onNotification:
                                      (ScrollNotification notification) {
                                    if (notification
                                        is ScrollUpdateNotification) {
                                      if (controller.videoScrollCtrl.position
                                                  .pixels >
                                              controller
                                                      .videoScrollCtrl
                                                      .position
                                                      .maxScrollExtent -
                                                  30 &&
                                          !controller
                                              .isLoadingMoreVideos.value &&
                                          !controller.lockVideos.value) {
                                        controller.getVideos();
                                      }
                                    }
                                    return true;
                                  },
                                  child: GridView.builder(
                                    // shrinkWrap: true,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    controller: controller.videoScrollCtrl,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 130 / 100,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (ctx, ind) =>
                                        VideoBoxNavigator(
                                      themeData: Get.textTheme,
                                      video: controller.videos[ind],
                                    ),
                                    itemCount: controller.videos.length,
                                  ),
                                ),
                              )
                            : const Center(child: LoadingWidget()));
                      } else {
                        return Obx(() => !controller.isLoadingPlaylists.value
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: NotificationListener(
                                  onNotification:
                                      (ScrollNotification notification) {
                                    if (notification
                                        is ScrollUpdateNotification) {
                                      if (controller.playlistScrollCtrl.position
                                                  .pixels >
                                              controller
                                                      .playlistScrollCtrl
                                                      .position
                                                      .maxScrollExtent -
                                                  30 &&
                                          !controller
                                              .isLoadingMorePlaylists.value &&
                                          !controller.lockPlaylists.value) {
                                        controller.getPlaylists();
                                      }
                                    }
                                    return true;
                                  },
                                  child: GridView.builder(
                                    // shrinkWrap: true,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    controller: controller.playlistScrollCtrl,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: .8,
                                      crossAxisSpacing: 7,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder: (ctx, ind) =>
                                        PlayListNavigatorBox(
                                      themeData: Get.textTheme,
                                      playlist: controller.playlists[ind],
                                      // paddingRight: 14,
                                    ),
                                    itemCount: controller.playlists.length,
                                  ),
                                ),
                              )
                            : const Center(child: LoadingWidget()));
                      }
                    });
                  },
                ),
              ),

              // const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
