import '../../../Core/Models/global.dart';

class TestModel {
  final String id;

  TestModel({
    required this.id,
  });

  factory TestModel.fromJson(Map datas) {
    return TestModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
    );
  }
}
