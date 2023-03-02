import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/empty2.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../Music/Widget/playlist_box.dart';
import '../Controllers/playlist_list.dart';

class PlaylistListScreen extends StatefulWidget {
  const PlaylistListScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistListScreen> createState() => _PlaylistListScreenState();
}

class _PlaylistListScreenState extends State<PlaylistListScreen> {
  @override
  void dispose() {
    Get.delete<PlaylistListController>();
    super.dispose();
  }

  final PlaylistListController provider = Get.put(PlaylistListController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const MiniMusicPlayerBox(),
        appBar: GlobalAppbar(
          subtitle: 'what we arranged',
          title: 'Playlists',
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(child: LoadingWidget())
              : NotificationListener(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (provider.scrollController.position.pixels >
                              provider.scrollController.position
                                      .maxScrollExtent -
                                  30 &&
                          !provider.isLoadingMore.value) {
                        provider.getPlaylists();
                      }
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        provider.getPlaylists(resetPage: true),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ListView(
                          controller: provider.scrollController,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: InputBox(
                                    label: 'What do you looking for?',
                                    controller: provider.searchCtrl,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    provider.getPlaylists(fromSearch: true);
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
                            const SizedBox(height: 25),
                            !provider.isLoading.value
                                ? provider.playlists.isNotEmpty
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 85 / 100,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 15,
                                        ),
                                        itemBuilder: (ctx, ind) =>
                                            PlayListNavigatorBox(
                                          themeData: themeData,
                                          playlist: provider.playlists[ind],
                                          letRestartLive: false,
                                        ),
                                        itemCount: provider.playlists.length,
                                      )
                                    : const EmptyBox2(
                                        icon: FlutterIcons.playlist,
                                      )
                                : const LoadingWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
