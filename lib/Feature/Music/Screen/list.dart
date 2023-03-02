import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../Controllers/list.dart';
import '../Widget/row_navigator.dart';

class MusicListScreen extends StatefulWidget {
  const MusicListScreen({Key? key}) : super(key: key);

  @override
  State<MusicListScreen> createState() => _MusicListScreenState();
}

class _MusicListScreenState extends State<MusicListScreen> {
  @override
  void dispose() {
    Get.delete<MusicListController>();
    super.dispose();
  }

  final MusicListController provider = Get.put(MusicListController());
  @override
  Widget build(BuildContext context) {
    final TextTheme themeData = Theme.of(context).textTheme;
    return Obx(
      () => SafeArea(
        child: Scaffold(
          bottomNavigationBar: const MiniMusicPlayerBox(),
          appBar: GlobalAppbar(
            subtitle: 'listen to the music',
            title: 'Musics',
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
                    child: RefreshIndicator(
                      onRefresh: () => provider.fetchDatas(
                        resetPage: true,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: ListView(
                          controller: provider.scrollCtrl,
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, ind) => MusicRowNavigator(
                                themeData: themeData,
                                music: provider.datas[ind],
                                // refteshPageFunction: () => provider.fetchDatas(
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
      ),
    );
  }
}
