// ignore_for_file: empty_catches

import 'package:nojoum/Feature/Music/Model/music.dart';

import '../../../Core/Models/global.dart';

class PlayListModel {
  final String id, name, slug, userId, genreId, genreName, image, thumbnail;
  final List<MusicModel> musics;
  PlayListModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.userId,
    required this.genreName,
    required this.genreId,
    required this.image,
    required this.thumbnail,
    required this.musics,
  });

  factory PlayListModel.fromJson(Map datas) {
    // for (var item in datas.keys) {
    //   print(item);
    //   print(datas[item]);
    // }
    List<MusicModel> musics = [];
    try {
      datas['music'].forEach((element) {
        musics.add(MusicModel.fromJson(element));
      });
    } catch (e) {}

    String genreName = '';
    try {
      genreName = GlobalEntity.dataFilter(datas['genre']['name']);
    } catch (e) {}
    return PlayListModel(
      id: GlobalEntity.dataFilter(datas['id']),
      name: GlobalEntity.dataFilter(datas['name']),
      slug: GlobalEntity.dataFilter(datas['slig']),
      userId: GlobalEntity.dataFilter(datas['user_id']),
      genreName: genreName,
      genreId: GlobalEntity.dataFilter(datas['genre_id']),
      image: GlobalEntity.dataFilter(datas['image']),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      musics: musics,
    );
  }
}
