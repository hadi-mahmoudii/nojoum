import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Feature/Post/Controllers/explore.dart';

import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/main_screen.dart';
import '../../Music/Controllers/details.dart';
import '../Widgets/explore_row.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

final controller = Get.find<ExploreController>();

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin<ExploreScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final musicProvider = Get.find<MusicDetailsController>();
    return Scaffold(
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
        title: const Text(
          'Explore',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed(Routes.searchMedia);
            },
            icon: const Icon(
              FlutterIcons.search_1,
              size: 30,
            ),
          ),
          const SizedBox(width: 5),
        ],
        centerTitle: false,
      ),
      //TODO: add pagination
      body: FilterWidget(
        child: Stack(
          children: [
            Center(
              child: controller.obx(
                (stories) => RefreshIndicator(
                  onRefresh: () => controller.getStories(resetPage: true),
                  child: ListView(
                    children: [
                      // const SizedBox(height: 20),
                      // SimpleHeader(
                      //   mainHeader: 'EXPLORE',
                      //   showRightAngle: true,
                      //   angleIcon: FlutterIcons.search_1,
                      //   angleFuncion: () => Get.toNamed(Routes.searchMedia),
                      // ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                            Directionality(
                          textDirection: index.isOdd
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: ExploreRowImages(
                            stories: controller.getRowStoryPart(index),
                          ),
                        ),
                        itemCount: controller.storiesRowsCount.value,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
                onLoading: const LoadingWidget(),
              ),
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
