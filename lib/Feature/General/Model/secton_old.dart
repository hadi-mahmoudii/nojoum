import '../../../Core/Models/global.dart';

class HomeSectionModel {
  final String id, title, subtitle, displayType;
  final int sort;
  // final SectionModel section;
  // final List datas;

  HomeSectionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.displayType,
    required this.sort,
  });
}

class FeatureModel {
  final String id, title, subtitle, type, slug;
  final int sort;
  FeatureModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.slug,
    required this.sort,
  });

  factory FeatureModel.fromJson(Map datas) {
    return FeatureModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      title: GlobalEntity.dataFilter(datas['title'].toString()),
      subtitle: GlobalEntity.dataFilter(datas['sub_title'].toString()),
      type: GlobalEntity.dataFilter(datas['type'].toString()),
      slug: GlobalEntity.dataFilter(datas['slug'].toString()),
      sort: datas['sort'],
    );
  }
}
