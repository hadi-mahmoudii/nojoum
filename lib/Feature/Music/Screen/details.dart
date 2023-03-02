// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/loading.dart';
import '../../General/Widget/singer_navigator_row.dart';
import '../Controllers/details.dart';
import '../Widget/row_navigator.dart';
import '../Widget/voice_play_box.dart';

class MusicDetailsScreen extends StatelessWidget {
  const MusicDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print();
    return MusicDetailsTile(
      musicId: ModalRoute.of(context)!.settings.arguments as String,
    );
  }
}

class MusicDetailsTile extends StatefulWidget {
  const MusicDetailsTile({
    Key? key,
    required this.musicId,
  }) : super(key: key);
  final String musicId;
  @override
  _MusicDetailsTileState createState() => _MusicDetailsTileState();
}

class _MusicDetailsTileState extends State<MusicDetailsTile>
    with SingleTickerProviderStateMixin {
  final appSession = Get.find<AppSession>();
  final provider = Get.find<MusicDetailsController>();
  late TabController tabCtrl;
  int currentTabIndex = 0;

  @override
  void initState() {
    tabCtrl = TabController(length: 2, vsync: this);
    Future.microtask(() => provider.fetchData(widget.musicId, true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;

    return Obx(
      () => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            // Provider.of<AppSession>(context, listen: false)
            //     .changeLiveStatus(false);
            return true;
          },
          child: provider.isLoading.value
              ? const Scaffold(
                  body: FilterWidget(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  ),
                )
              : Scaffold(
                  appBar: GlobalAppbar(
                    subtitle: 'Listen to the song',
                    title: provider.music.name,
                    textTheme: themeData,
                  ).build(context),
                  body: FilterWidget(
                    child: SingleChildScrollView(
                      controller: provider.scrollCtrl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // ChampyaHeader(),
                          // SizedBox(height: 15),
                          // AspectRatio(
                          //   aspectRatio: 2,
                          //   child: FlickVideoPlayer(
                          //     flickManager: provider.flickManager,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Image.network(
                              provider.music.image,
                              width: MediaQuery.of(context).size.width - 40,
                              height: MediaQuery.of(context).size.width - 40,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, _, __) => Image.asset(
                                'assets/Images/musicplaceholder.png',
                                width: MediaQuery.of(context).size.width - 40,
                                height: MediaQuery.of(context).size.width - 40,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // StreamBuilder<Duration>(
                          //   stream: provider.audioPlayer.positionStream,
                          //   builder: (ctx, value) => Text(
                          //     value.hasData
                          //         ? value.data!.inSeconds.toString()
                          //         : '-',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: AudioUiBox(
                              // url: provider.music.link,
                              // provider: provider,
                              mainCtx: context,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 60),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(color: Colors.white, width: .7),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  provider.music.playCount,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '''times
played''',
                                  style: themeData.headline3!
                                      .copyWith(height: .95),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Share.share('https://nojoum.app');
                                  },
                                  child: const Icon(
                                    FlutterIcons.whatsapp,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                appSession.token.isNotEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () {
                                            provider.changeFavoriteValue();
                                            provider.changeFavorite(
                                              provider.music.id,
                                              provider.isMyFavorite.value,
                                            );
                                          },
                                          child: Icon(
                                            provider.isMyFavorite.value
                                                ? FlutterIcons.heart
                                                : FlutterIcons.heart_empty,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                appSession.token.isNotEmpty
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () async {
                                            var datas = await provider
                                                .getUserPlaylists();

                                            provider.addDialog(
                                              context,
                                              provider.music.id,
                                              datas,
                                            );
                                          },
                                          child: const Icon(
                                            FlutterIcons.plus_linear,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          provider.music.artist.id.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SingerNavigatorRow(
                                    themeData: themeData,
                                    artist: provider.music.artist,
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 50),

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
                                  text: 'NEXT SONGS',
                                ),
                                Tab(
                                  text: 'LYRIC',
                                ),
                              ],
                            ),
                          ),

                          Builder(
                            builder: (_) {
                              if (currentTabIndex == 0) {
                                return ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (ctx, ind) =>
                                            MusicRowNavigator(
                                          themeData: themeData,
                                          music: provider.nextMusics[ind],
                                          letRaplaceRoute: true,
                                        ),
                                        separatorBuilder: (ctx, ind) =>
                                            const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Divider(
                                            color: Colors.white,
                                            height: 20,
                                            thickness: .2,
                                          ),
                                        ),
                                        itemCount: provider.nextMusics.length,
                                      ),
                                    ),
                                  ],
                                ); //1st custom tabBarView
                              } else {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  child: provider.music.lyric.isNotEmpty
                                      ? Text(
                                          provider.music.lyric,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'cairo',
                                          ),
                                        )
                                      : const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(
                                              '''THIS SONG HAVE NO LYRIC''',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                ); //2nd tabView
                              }
                            },
                          ),
                          const SizedBox(height: 50),
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
