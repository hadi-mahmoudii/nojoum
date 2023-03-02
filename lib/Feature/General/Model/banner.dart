// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Feature/General/Model/artist.dart';
import 'package:nojoum/Feature/General/Model/radio.dart';
import 'package:nojoum/Feature/Music/Model/music.dart';
import 'package:nojoum/Feature/Video/Models/video.dart';

import '../../../Core/Models/global.dart';
import '../../Music/Model/playlist.dart';
import '../../News/Models/news.dart';

class BannerModel {
  final String id, name, link, image, thumbnail, contentId, contentType, route;
  final media;

  BannerModel({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    required this.thumbnail,
    required this.contentId,
    required this.contentType,
    required this.route,
    required this.media,
  });

  factory BannerModel.fromJson(Map datas) {
    // log(datas.toString());
    // var media;
    final String type =
        GlobalEntity.dataFilter(datas['featureable_type'].toString());
    var media;
    String route = '';
    // try {
    switch (type) {
      case 'music':
        media = MusicModel.fromJson(datas['media']);
        route = Routes.musicDetails;
        break;
      case 'video':
        media = VideoModel.fromJson(datas['media']);
        route = Routes.videoDetails;
        break;
      case 'radio_station':
        media = RadioModel.fromJson(datas['media']);
        route = Routes.radioDetails;
        break;
      case 'news':
        media = NewsModel.fromJson(datas['media']);
        route = Routes.newsDetails;
        break;
      case 'playlist':
        media = PlayListModel.fromJson(datas['media']);
        route = Routes.playlistDetails;
        break;
      case 'artist':
        media = ArtistModel.fromJson(datas['media']);
        route = Routes.singerInfo;
        break;
      default:
        media = '';
        break;
    }
    // } catch (_) {
    //   media = '';
    // }

    return BannerModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      link: GlobalEntity.dataFilter(datas['link'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      contentId: GlobalEntity.dataFilter(datas['featureable_id'].toString()),
      media: media,
      route: route,
      contentType: type,
      // media: media,
    );
  }
}
