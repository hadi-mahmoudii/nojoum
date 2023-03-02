import '../../../Core/Models/global.dart';
import '../../General/Model/artist.dart';

class VideoModel {
  final String id,
      name,
      description,
      lyric,
      link,
      image,
      thumbnail,
      length,
      playCount;
  final ArtistModel artist;
  final bool isFavorite, isExclusive;

  VideoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.lyric,
    required this.link,
    required this.image,
    required this.thumbnail,
    required this.length,
    required this.playCount,
    required this.artist,
    required this.isFavorite,
    required this.isExclusive,
  });

  factory VideoModel.fromJson(Map datas) {
    late ArtistModel artist;
    late bool isFavorite, isExclusive;
    try {
      isFavorite = datas['hasFavorite'];
    } catch (e) {
      isFavorite = false;
    }
    try {
      if (datas['exclusive'] == 1) {
        isExclusive = true;
      } else {
        isExclusive = false;
      }
    } catch (e) {
      isExclusive = false;
    }
    try {
      artist = ArtistModel.fromJson(datas['artist']);
    } catch (e) {
      artist = ArtistModel(
        id: '',
        name: '',
        email: '',
        image: '',
        genreName: '',
        thumbnail: '',
      );
    }
    String finalPlaycount = '0';
    try {
      final count = int.parse(GlobalEntity.dataFilter(
          datas['played_count'].toString(),
          replacement: '0'));
      if (count >= 1000) {
        finalPlaycount = (count / 1000).floor().toString() + 'K';
      } else {
        finalPlaycount = count.toString();
      }
    } catch (_) {}
    return VideoModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      description: GlobalEntity.dataFilter(datas['description'].toString()),
      lyric: GlobalEntity.dataFilter(datas['lyric'].toString()),
      link: GlobalEntity.dataFilter(datas['link'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      length: GlobalEntity.formatedTime(datas['length'].toString()),
      playCount: finalPlaycount,
      artist: artist,
      isFavorite: isFavorite,
      isExclusive: isExclusive,
    );
  }
}
