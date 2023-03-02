import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/empty2.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../Music/Widget/row_navigator.dart';
import '../../Video/Widgets/box_navigator.dart';
import '../Controllers/my_favorites.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabCtrl;
  int currentTabIndex = 0;
  @override
  initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);
    // Future.microtask(
    //   () => Provider.of<MyFavoritesProvider>(context, listen: false)
    //       .getDatas(context),
    // );
  }

  @override
  void dispose() {
    Get.delete<MyFavoritesController>();
    super.dispose();
  }

  final MyFavoritesController provider = Get.put(MyFavoritesController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const MiniMusicPlayerBox(),
        appBar: GlobalAppbar(
          subtitle: 'your favorite songs and videos',
          title: 'My Favorites',
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(
                  child: LoadingWidget(),
                )
              : RefreshIndicator(
                  onRefresh: () async => provider.getDatas(resetPage: true),
                  child: ListView(
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TabBar(
                          labelColor: Colors.white,
                          indicatorColor: Colors.white,
                          unselectedLabelColor: const Color(0XFFA8A8A8),
                          controller: tabCtrl,
                          onTap: (index) {
                            setState(() {
                              currentTabIndex = index;
                            });
                          },
                          tabs: const [
                            Tab(
                              text: 'MUSIC',
                            ),
                            Tab(
                              text: 'VIDEOES',
                            ),
                          ],
                        ),
                      ),
                      Builder(builder: (_) {
                        if (currentTabIndex == 0) {
                          if (provider.musics.isNotEmpty) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (ctx, ind) => MusicRowNavigator(
                                  themeData: themeData,
                                  music: provider.musics[ind],
                                  // letRaplaceRoute: true,
                                ),
                                separatorBuilder: (ctx, ind) => const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: Colors.white,
                                    height: 20,
                                    thickness: .2,
                                  ),
                                ),
                                itemCount: provider.musics.length,
                              ),
                            );
                          } else {
                            return const EmptyBox2(
                              icon: FlutterIcons.music,
                            );
                          }
                        } else {
                          if (provider.videoes.isNotEmpty) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 130 / 100,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15,
                                ),
                                itemBuilder: (ctx, ind) => VideoBoxNavigator(
                                  themeData: themeData,
                                  video: provider.videoes[ind],
                                  letRestartLive: false,
                                ),
                                itemCount: provider.videoes.length,
                              ),
                            );
                          } else {
                            return const EmptyBox2(
                              icon: FlutterIcons.video,
                            );
                          }
                        }
                      }),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
