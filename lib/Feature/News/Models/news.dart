// ignore_for_file: empty_catches

import '../../../Core/Models/date_convertor.dart';
import '../../../Core/Models/global.dart';

class NewsModel {
  final String id, name, slug, date, description, image, thumbnail, video;
  final List<NewsModel> similarNews;
  final bool isExclusive;
  NewsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.date,
    required this.description,
    required this.image,
    required this.thumbnail,
    required this.video,
    required this.similarNews,
    required this.isExclusive,
  });

  factory NewsModel.fromJson(Map datas) {
    // for (var item in datas.keys) {
    //   print(item);
    //   print(datas[item]);
    // }
    List<NewsModel> similarNews = [];
    // try {
    //   datas['music'].forEach((element) {
    //     similarNews.add(MusicModel.fromJson(element));
    //   });
    // } catch (e) {}
    late bool isExclusive;
    try {
      if (datas['exclusive'] == 1) {
        isExclusive = true;
      } else {
        isExclusive = false;
      }
    } catch (e) {
      isExclusive = false;
    }
    return NewsModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['title']),
      slug: GlobalEntity.dataFilter(datas['slig']),
      date: DateConvertor.dateFormatter(
        GlobalEntity.dataFilter(datas['created_at'].toString()),
      ),
      description: GlobalEntity.dataFilter(datas['description']),
      image: GlobalEntity.dataFilter(datas['image']),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      video: GlobalEntity.dataFilter(datas['video_link']),
      similarNews: similarNews,
      isExclusive: isExclusive,
    );
  }
}
