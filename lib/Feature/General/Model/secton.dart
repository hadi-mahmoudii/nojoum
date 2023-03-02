import 'package:nojoum/Feature/General/Model/artist.dart';

import 'banner.dart';
import 'features.dart';
import 'radio.dart';
import '../../Music/Model/music.dart';
import '../../Music/Model/playlist.dart';
import '../../News/Models/news.dart';
import '../../Video/Models/video.dart';

import '../../../Core/Models/global.dart';

class HomeSectionModel {
  final String id, title, subtitle, displayType, type;
  final int sort;
  final List<FeatureModel> features;
  final double topMargin;
  // final SectionModel section;
  // final List datas;

  HomeSectionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.displayType,
    required this.sort,
    required this.features,
    required this.topMargin,
  });

  factory HomeSectionModel.fromJson(Map datas) {
    double topMargin = 30;
    try {
      topMargin = double.parse(datas['style']['margin'].toString());
    } catch (_) {}
    final String type = GlobalEntity.dataFilter(
      datas['type'].toString(),
      replacement: '',
    );
    List<FeatureModel> features = [];
    datas['features'].forEach((element) {
      features.add(FeatureModel.fromJson(element, type));
    });
    return HomeSectionModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      title: GlobalEntity.dataFilter(datas['title'].toString()),
      subtitle: GlobalEntity.dataFilter(datas['sub_title'].toString()),
      displayType: GlobalEntity.dataFilter(datas['display_type'].toString()),
      type: type,
      sort: datas['sort'],
      features: features,
      topMargin: topMargin,
    );
  }
}

class FeatureModel {
  final String id, parentType, childType;
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final bool haveError;
  FeatureModel({
    required this.id,
    required this.parentType,
    required this.childType,
    required this.data,
    required this.haveError,
  });

  factory FeatureModel.fromJson(Map datas, String parentType) {
    bool haveError = false;
    final String childType =
        GlobalEntity.dataFilter(datas['featureable_type'].toString());
    Object data;
    try {
      switch (parentType) {
        case 'music':
          data = MusicModel.fromJson(datas['media']);
          break;
        case 'video':
          data = VideoModel.fromJson(datas['media']);
          break;
        case 'banner':
          data = BannerModel.fromJson(datas);
          break;
        case 'radio_station':
          data = RadioModel.fromJson(datas['media']);
          break;
        case 'news':
          data = NewsModel.fromJson(datas['media']);
          break;
        case 'playlist':
          data = PlayListModel.fromJson(datas['media']);
          break;
        case 'featured':
          data = FeaturedModel.fromJson(datas);
          break;
        case 'artist':
          // log(datas.toString());
          data = ArtistModel.fromJson(datas['media']);
          break;
        default:
          haveError = true;
          data = '';
      }
    } catch (_) {
      haveError = true;
      data = '';
    }

    return FeatureModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      parentType: parentType,
      childType: childType,
      data: data,
      haveError: haveError,
    );
  }
}
