// ignore_for_file: empty_catches

import 'package:nojoum/Core/Models/date_convertor.dart';

import '../../../Core/Models/global.dart';

class CommentModel {
  final String id, comment, date, user;
  final List<CommentModel> childComments;
  CommentModel({
    required this.id,
    required this.comment,
    required this.date,
    required this.user,
    required this.childComments,
  });

  factory CommentModel.fromJson(Map datas) {
    List<CommentModel> childComments = [];
    try {
      datas['children'].forEach((element) {
        childComments.add(CommentModel.fromJson(element));
      });
    } catch (e) {}
    return CommentModel(
      id: GlobalEntity.dataFilter(datas['id']),
      comment: GlobalEntity.dataFilter(datas['message']),
      date: DateConvertor.dateFormatter(
        GlobalEntity.dataFilter(datas['created_at'].toString()),
      ),
      user: GlobalEntity.dataFilter(datas['user']['name']),
      childComments: childComments,
    );
  }
}
