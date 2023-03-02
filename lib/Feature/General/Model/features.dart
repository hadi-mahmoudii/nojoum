// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Feature/General/Model/radio.dart';

import '../../../Core/Models/global.dart';
import '../../Music/Model/music.dart';
import '../../Music/Model/playlist.dart';
import '../../News/Models/news.dart';
import '../../Video/Models/video.dart';

class FeaturedModel {
  final String id, name, email, image, thumbnail, featureId, featureType, route;
  final IconData icon;
  final media;

  FeaturedModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.thumbnail,
    required this.featureId,
    required this.featureType,
    required this.icon,
    required this.route,
    required this.media,
  });

  factory FeaturedModel.fromJson(Map datas) {
    var media;
    String route = '';
    IconData icon = FlutterIcons.switch_icon;
    final String type =
        GlobalEntity.dataFilter(datas['featureable_type'].toString());
    switch (type) {
      case 'music':
        media = MusicModel.fromJson(datas['media']);
        route = Routes.musicDetails;
        icon = FlutterIcons.music;
        break;
      case 'video':
        media = VideoModel.fromJson(datas['media']);
        route = Routes.videoDetails;
        icon = FlutterIcons.play;
        break;
      case 'radio_station':
        media = RadioModel.fromJson(datas['media']);
        route = Routes.radioDetails;
        icon = FlutterIcons.radio;
        break;
      case 'news':
        media = NewsModel.fromJson(datas['media']);
        route = Routes.newsDetails;
        icon = FlutterIcons.rss;
        break;
      case 'playlist':
        media = PlayListModel.fromJson(datas['media']);
        route = Routes.playlistDetails;
        icon = FlutterIcons.playlist_linear;
        break;
      default:
        media = '';
        break;
    }

    return FeaturedModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      email: GlobalEntity.dataFilter(datas['email'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      featureId: GlobalEntity.dataFilter(datas['featureable_id'].toString()),
      icon: icon,
      route: route,
      featureType: type,
      media: media,
    );
  }
}
