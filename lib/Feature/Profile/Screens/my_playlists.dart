import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_addable_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../../Music/Widget/playlist_box.dart';
import '../Controllers/my_playlists.dart';

class MyPlayListsScreen extends StatefulWidget {
  const MyPlayListsScreen({Key? key}) : super(key: key);

  @override
  State<MyPlayListsScreen> createState() => _MyPlayListsScreenState();
}

class _MyPlayListsScreenState extends State<MyPlayListsScreen> {
  @override
  void dispose() {
    Get.delete<MyPlaylistsController>();
    super.dispose();
  }

  final MyPlaylistsController provider = Get.put(MyPlaylistsController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const MiniMusicPlayerBox(),
        appBar: GlobalAddableAppbar(
          subtitle: 'playlists that you like and create',
          title: 'My Playlists',
          textTheme: themeData,
          func: () => provider.addDialog(context),
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(child: LoadingWidget())
              : RefreshIndicator(
                  onRefresh: () async => provider.getPlaylists(resetPage: true),
                  child: provider.playlists.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 85 / 100,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (ctx, ind) => PlayListNavigatorBox(
                                themeData: themeData,
                                playlist: provider.playlists[ind],
                                letRestartLive: false,
                                isMyPlaylist: true,
                              ),
                              itemCount: provider.playlists.length,
                            ),
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Center(
                                  child: Icon(
                                    FlutterIcons.playlist_linear,
                                    size: 117,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '''no item at the 
moment'''
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Please add a new one',
                                  style: TextStyle(
                                    color: Color(0XFF9E9E9E),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SubmitButton2(
                                  func: () => provider.addDialog(context),
                                  icon: null,
                                  title: 'ADD',
                                ),
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
