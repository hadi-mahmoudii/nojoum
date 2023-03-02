import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/empty2.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../Controllers/playlist_details.dart';
import '../Widget/playlist_music_row_navigator.dart';

class PlaylistDetailsScreen extends GetView<PlaylistDetailsController> {
  const PlaylistDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          bottomNavigationBar: const MiniMusicPlayerBox(),
          appBar: GlobalAppbar(
            subtitle: 'listen to the song',
            title: controller.isLoading.value
                ? 'LOVE SONG'
                : controller.playlist.name,
            textTheme: themeData,
          ).build(context),
          body: FilterWidget(
            child: controller.isLoading.value
                ? const Center(
                    child: LoadingWidget(),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              ClipRRect(
                                // borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  controller.playlist.image,
                                  height: 165,
                                  width: 165,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/Images/playlistplaceholder.png',
                                    height: 165,
                                    width: 165,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.playlist.name,
                                      style: themeData.headline5,
                                    ),
                                    const SizedBox(height: 5),
                                    controller.playlist.genreName.isNotEmpty
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                FlutterIcons.playlist,
                                                color: Color(0XFF9E9E9E),
                                                size: 14,
                                              ),
                                              const SizedBox(width: 3),
                                              Expanded(
                                                child: Text(
                                                  controller.playlist.genreName,
                                                  style: themeData.overline,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        controller.playlist.musics.isNotEmpty
                            ? ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                controller: controller.scrollCtrl,
                                itemBuilder: (ctx, ind) =>
                                    PlaylistMusicRowNavigator(
                                  themeData: themeData,
                                  music: controller.musics[ind],
                                  isMyPlaylist: controller.isMyPlaylist,
                                  // refteshPageFunction: () => controller.fetchDatas(
                                  //   context,
                                  //   resetPage: true,
                                  // ),
                                ),
                                separatorBuilder: (ctx, ind) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: .2,
                                  ),
                                ),
                                itemCount: controller.musics.length,
                              )
                            : const EmptyBox2(
                                icon: FlutterIcons.music_linear,
                                topHeight: 100,
                              ),
                      ],
                    )),
          ),
        ),
      ),
    );
  }
}
