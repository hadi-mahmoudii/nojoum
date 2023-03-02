import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/mini_music_player.dart';
import 'package:nojoum/Core/main_screen.dart';
import 'package:nojoum/Feature/General/Controllers/browse.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../Widget/browse_row_navigator.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void dispose() {
    Get.delete<BrowseController>();
    super.dispose();
  }

  final BrowseController provider = Get.put(BrowseController());
  final musicProvider = Get.find<MusicDetailsController>();
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => FilterWidget(
        child: provider.isLoading.value
            ? const Center(
                child: LoadingWidget(),
              )
            : Stack(
                children: [
                  ListView(
                    controller: provider.scrollCtrl,
                    children: [
                      const SizedBox(height: 20),
                      const SimpleHeader(
                        mainHeader: 'BROWSE',
                        showRightAngle: false,
                      ),
                      const SizedBox(height: 35),
                      BrowseRowNavigator(
                        themeData: themeData,
                        title: 'music',
                        subtitle: 'Listen to thousands of arab music',
                        route: Routes.musicList,
                        icon: FlutterIcons.music,
                      ),
                      BrowseRowNavigator(
                        themeData: themeData,
                        title: 'Videos',
                        subtitle: 'Hottest arab music videos',
                        route: Routes.videoList,
                        icon: FlutterIcons.play_1,
                      ),
                      // BrowseRowNavigator(
                      //   themeData: themeData,
                      //   title: 'podcasts',
                      //   subtitle: 'Hottest arab music videos',
                      //   route: '',
                      //   icon: FlutterIcons.mic,
                      // ),
                      BrowseRowNavigator(
                        themeData: themeData,
                        title: 'playlists',
                        subtitle: 'We arranged for you',
                        route: Routes.playlists,
                        icon: FlutterIcons.playlist,
                      ),
                      BrowseRowNavigator(
                        themeData: themeData,
                        title: 'News',
                        subtitle: 'Catch up.',
                        route: Routes.newsList,
                        icon: FlutterIcons.rss,
                      ),
                    ],
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GlobalBottomNavigationBar(),
                  ),
                  musicProvider.hasValue.value
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
    );
  }
}
