import '../../../Core/Models/global.dart';
import '../../General/Model/artist.dart';

class MusicModel {
  final String id,
      name,
      description,
      link,
      image,
      thumbnail,
      lyric,
      length,
      playCount;
  final ArtistModel artist;
  final bool isFavorite, isExclusive;

  MusicModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.thumbnail,
    required this.link,
    required this.lyric,
    required this.artist,
    required this.playCount,
    required this.length,
    required this.isFavorite,
    required this.isExclusive,
  });

  factory MusicModel.fromJson(Map datas) {
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
    return MusicModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      description: GlobalEntity.dataFilter(datas['description'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      link: GlobalEntity.dataFilter(datas['music'].toString()),
      lyric: GlobalEntity.dataFilter(datas['lyric'].toString()),
      length: GlobalEntity.formatedTime(datas['length'].toString()),
      playCount: finalPlaycount,
      artist: artist,
      isFavorite: isFavorite,
      isExclusive: isExclusive,
    );
  }
}
