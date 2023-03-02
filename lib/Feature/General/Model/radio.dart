import '../../../Core/Models/global.dart';

class RadioModel {
  final String id, name, link, image, thumbnail;
  final bool isLive;
  RadioModel({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    required this.thumbnail,
    required this.isLive,
  });

  factory RadioModel.fromJson(Map datas) {
    bool isLive = false;
    try {
      if (datas['live'] == 1) isLive = true;
    } catch (e) {
      isLive = false;
    }
    return RadioModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      link: GlobalEntity.dataFilter(datas['link'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      isLive: isLive,
    );
  }
}
