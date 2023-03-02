import '../../../Core/Models/global.dart';

class ArtistModel {
  final String id, name, email, image, thumbnail, genreName;

  ArtistModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.thumbnail,
    required this.genreName,
  });

  factory ArtistModel.fromJson(Map datas) {
    String genreName = '';
    try {
      genreName = GlobalEntity.dataFilter(datas['genre']['subject'].toString());
    } catch (_) {}
    return ArtistModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      name: GlobalEntity.dataFilter(datas['name'].toString()),
      email: GlobalEntity.dataFilter(datas['email'].toString()),
      image: GlobalEntity.dataFilter(datas['image'].toString()),
      thumbnail: GlobalEntity.dataFilter(datas['app_thumbnail'].toString()),
      genreName: genreName,
    );
  }
}
