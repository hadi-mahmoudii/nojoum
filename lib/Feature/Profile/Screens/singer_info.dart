import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../Music/Widget/row_navigator.dart';
import '../../Video/Widgets/box_navigator.dart';
import '../Controllers/singer_info.dart';

class SingerInfoScreen extends StatefulWidget {
  const SingerInfoScreen({Key? key}) : super(key: key);

  @override
  State<SingerInfoScreen> createState() => _SingerInfoScreenState();
}

class _SingerInfoScreenState extends State<SingerInfoScreen> {
  // @override
  // initState() {
  //   super.initState();
  //   Future.microtask(
  //     () => Provider.of<SingerInfoProvider>(context, listen: false)
  //         .getDatas(context),
  //   );
  // }

  @override
  void dispose() {
    Get.delete<SingerInfoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SingerInfoController provider = Get.put(SingerInfoController(
      ModalRoute.of(context)!.settings.arguments as String,
    ));
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => provider.isLoading.value
          ? const Scaffold(
              body: FilterWidget(
                child: Center(child: LoadingWidget()),
              ),
            )
          : Scaffold(
              bottomNavigationBar: const MiniMusicPlayerBox(),
              appBar: GlobalAppbar(
                subtitle: 'Artist page',
                title: provider.singer.name,
                textTheme: themeData,
              ).build(context),
              body: FilterWidget(
                child: RefreshIndicator(
                  onRefresh: () async => provider.getDatas(resetPage: true),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                provider.singer.image,
                                width:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                height:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (ctx, obj, _) => Center(
                                  child: Image.asset(
                                    'assets/Images/userplaceholder.png',
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        5,
                                    height: MediaQuery.of(context).size.width *
                                        2 /
                                        5,
                                    fit: BoxFit.fitHeight,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 2 / 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Spacer(),
                                    Text(
                                      provider.singer.name,
                                      style: themeData.headline5,
                                    ),
                                    const SizedBox(height: 5),

                                    Text(
                                      provider.singer.genreName,
                                      style: themeData.button,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          provider.singer.playCount,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '''total
plays''',
                                          style: themeData.bodyText1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      provider.singer.bio.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Text(
                                    'BIO',
                                    textAlign: TextAlign.left,
                                    style: themeData.headline3!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    provider.singer.bio,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: themeData.button!
                                        .copyWith(fontFamily: 'cairo'),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 40),
                      provider.singer.videoes.isNotEmpty
                          ? const SimpleHeader(mainHeader: 'VIDEOS')
                          : Container(),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          provider.singer.videoes.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 50),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: GridView.builder(
                                    // controller: provider.scrollCtrl,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 130 / 100,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 15,
                                    ),
                                    itemBuilder: (ctx, ind) =>
                                        VideoBoxNavigator(
                                      themeData: themeData,
                                      video: provider.singer.videoes[ind],
                                      letRestartLive: false,
                                    ),
                                    itemCount: provider.singer.videoes.length,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      provider.singer.musics.isNotEmpty
                          ? const SimpleHeader(mainHeader: 'TOP SONGS')
                          : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, ind) => MusicRowNavigator(
                            themeData: themeData,
                            music: provider.singer.musics[ind],
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
                          itemCount: provider.singer.musics.length,
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
