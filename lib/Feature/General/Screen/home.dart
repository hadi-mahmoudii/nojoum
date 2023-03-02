import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/app_session.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Core/Widgets/mini_music_player.dart';
import 'package:nojoum/Core/main_screen.dart';
import 'package:nojoum/Feature/General/Widget/top_live_banner.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';
import 'package:nojoum/Feature/Post/Controllers/stories.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';
import '../Controllers/home.dart';
import '../Widget/section_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  final HomeController provider = Get.put(HomeController());
  final musicController = Get.find<MusicDetailsController>();
  final liveController = Get.find<LiveVideoController>();

  @override
  void initState() {
    liveController.getLive();
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
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
          // title: const Text(
          //   'NOJOUM',
          //   style: TextStyle(
          //     fontSize: 24,
          //   ),
          // ),
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
                FlutterIcons.nojoom_search,
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
          child: RefreshIndicator(
            onRefresh: () async {
              await liveController.stopLive(true);
              Get.find<StoriesController>().getStories(resetPage: true);
              liveController.getLive(resetPage: true);
              provider.fetchDatas(resetPage: true);
            },
            child: Stack(
              children: [
                provider.isLoading.value
                    ? const Center(
                        child: LoadingWidget(),
                      )
                    // this list view use to prevent rebuild widgets
                    : ListView(
                        children: [
                          // StoryHeaderBox(),
                          // for showing or hide space behind video player
                          SizedBox(
                              height: liveController.letShowLive.value &&
                                      !musicController.hasValue.value
                                  ? 210
                                  : 0),
                          ListView.separated(
                            padding: const EdgeInsets.only(bottom: 150),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, ind) => SectionBox(
                                section: provider.sections[ind],
                                themeData: themeData),
                            separatorBuilder: (ctx, ind) =>
                                const SizedBox(height: 0),
                            itemCount: provider.sections.length,
                          )
                        ],
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
      ),
    );
  }
}
