import '../../../Core/Models/global.dart';

class MyFeedModel {
  final String id;

  MyFeedModel({
    required this.id,
  });

  factory MyFeedModel.fromJson(Map datas) {
    return MyFeedModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
    );
  }
}
