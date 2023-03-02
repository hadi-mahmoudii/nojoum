import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../Controllers/list.dart';
import '../Widgets/box_navigator.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  // @override
  // void dispose() {
  //   // Get.delete<VideoListController>();
  //   super.dispose();
  // }

  final VideoListController provider = Get.find<VideoListController>();
  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          bottomNavigationBar: const MiniMusicPlayerBox(),
          appBar: GlobalAppbar(
            subtitle: 'Watch the world',
            title: 'Videos',
            textTheme: themeData,
          ).build(context),
          body: FilterWidget(
            child: provider.isLoading.value
                ? const Center(
                    child: LoadingWidget(),
                  )
                : NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollUpdateNotification) {
                        if (provider.scrollCtrl.position.pixels >
                                provider.scrollCtrl.position.maxScrollExtent -
                                    30 &&
                            !provider.isLoadingMore.value) {
                          provider.fetchDatas();
                        }
                      }
                      return true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ListView(
                        children: [
                          GridView.builder(
                            controller: provider.scrollCtrl,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 130 / 100,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (ctx, ind) => VideoBoxNavigator(
                              themeData: themeData,
                              video: provider.datas[ind],
                              letRestartLive: false,
                            ),
                            itemCount: provider.datas.length,
                          ),
                          provider.isLoadingMore.value
                              ? const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: LoadingWidget(),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
