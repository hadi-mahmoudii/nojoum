import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Feature/General/Widget/playlist_section.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../News/Widgets/news_box.dart';
import '../../Video/Widgets/box_navigator.dart';
import '../Model/secton.dart';
import 'artist_section.dart';
import 'banner_row.dart';
import 'feature_box.dart';
import 'home_music_card.dart';
import 'radio_row.dart';

class SectionBox extends StatelessWidget {
  const SectionBox({
    Key? key,
    required this.section,
    required this.themeData,
  }) : super(key: key);
  final HomeSectionModel section;
  final TextTheme themeData;

  @override
  Widget build(BuildContext context) {
    String headerRoute = '';

    Widget sectionWidget = Container();

    switch (section.type) {
      case 'music':
        sectionWidget = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .8,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : HomeMusicBoxNavigator(
                  themeData: themeData,
                  music: section.features[ind].data,
                ),
          itemCount: section.features.length,
        );
        headerRoute = Routes.musicList;
        break;
      case 'video':
        sectionWidget = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 130 / 100,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : VideoBoxNavigator(
                  themeData: themeData,
                  video: section.features[ind].data,
                ),
          itemCount: section.features.length,
        );
        headerRoute = Routes.videoList;
        break;
      case 'featured':
        sectionWidget = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 130 / 100,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : FeatureBoxNavigator(
                  themeData: themeData,
                  feature: section.features[ind].data,
                ),
          itemCount: section.features.length,
        );
        break;
      case 'banner':
        sectionWidget = ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : BannerRowBox(banner: section.features[ind].data),
          separatorBuilder: (ctx, ind) => const SizedBox(height: 5),
          itemCount: section.features.length,
        );
        break;
      case 'radio_station':
        sectionWidget = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .8,
            crossAxisSpacing: 7,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : RadioRowBox(
                  themeData: themeData,
                  radio: section.features[ind].data,
                ),
          itemCount: section.features.length,
        );
        break;
      case 'news':
        sectionWidget = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 130 / 100,
            crossAxisSpacing: 10,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (ctx, ind) => section.features[ind].haveError
              ? Container()
              : NewsNavigatorBox(
                  themeData: themeData,
                  news: section.features[ind].data,
                  letRestartLive: false,
                ),
          itemCount: section.features.length,
        );
        headerRoute = Routes.newsList;
        break;
      case 'playlist':
        sectionWidget =
            HomePlayListSection(section: section, themeData: themeData);
        headerRoute = Routes.playlists;
        break;
      case 'artist':
        sectionWidget =
            HomeArtistSection(section: section, themeData: themeData);
        headerRoute = Routes.playlists;
        break;
      default:
    }

    // sections that not need horizental padding
    List<String> nonHorizentalPaddingSections = ['playlist', 'artist'];
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: section.features.isNotEmpty
          ? [
              SizedBox(height: section.topMargin),
              section.title != ''
                  ? SimpleHeader(
                      mainHeader: section.title,
                      subHeader: section.subtitle,
                      showRightAngle: section.type != 'radio_station' &&
                              section.type != 'featured'
                          ? true
                          : false,
                      angleIcon: FlutterIcons.angle_right,
                      angleFuncion: () {
                        Get.toNamed(headerRoute);
                      },
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(
                    right: !nonHorizentalPaddingSections.contains(section.type)
                        ? 20
                        : 0,
                    left: !nonHorizentalPaddingSections.contains(section.type)
                        ? 20
                        : 0,
                    bottom: 0,
                    top: section.type != 'placeholder' ? 20 : 0),
                child: sectionWidget,
              ),
            ]
          : [],
    );
  }
}
