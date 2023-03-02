import 'dart:developer';

import '../../../Core/Models/global.dart';
import '../../Music/Model/music.dart';
import '../../Video/Models/video.dart';

class SingerModel {
  final String id, name, bio, image, thumbnail, email, playCount, genreName;
  final List<VideoModel> videoes;
  final List<MusicModel> musics;
  SingerModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.image,
    required this.thumbnail,
    required this.musics,
    required this.videoes,
    required this.email,
    required this.playCount,
    required this.genreName,
  });

  factory SingerModel.fromJson(Map datas) {
    log(datas.toString());
    String genreName = '';
    try {
      genreName = GlobalEntity.dataFilter(datas['genre']['subject'].toString());
    } catch (_) {}
    List<VideoModel> videoes = [];
    try {
      datas['videos'].forEach((element) {
        videoes.add(VideoModel.fromJson(element));
      });
    } catch (_) {}
    List<MusicModel> musics = [];
    try {
      datas['musics'].forEach((element) {
        musics.add(MusicModel.fromJson(element));
      });
    } catch (_) {}
    return SingerModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['first_name']) +
          ' ' +
          GlobalEntity.dataFilter(datas['last_name']),
      bio: GlobalEntity.dataFilter(datas['bio']),
      playCount: GlobalEntity.dataFilter(datas['playedCount'].toString()),
      image: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      email: GlobalEntity.dataFilter(datas['email']),
      genreName: genreName,
      musics: musics,
      videoes: videoes,
    );
  }
}
