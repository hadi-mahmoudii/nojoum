// import 'package:champya/Core/Models/global.dart';

// class CommentModel {
//   final String id, user, comment;
//   final DateTime date;

//   CommentModel({
//     required this.id,
//     required this.user,
//     required this.comment,
//     required this.date,
//   });

//   factory CommentModel.fromJson(Map datas) {
//     DateTime date = DateTime.now();
//     try {
//       date = DateTime.parse((datas['created_at']));
//     } catch (e) {}
//     String user = '';
//     try {
//       user = GlobalEntity.dataFilter(datas['user']['first_name'].toString()) +
//           ' ' +
//           GlobalEntity.dataFilter(datas['user']['last_name'].toString());
//     } catch (e) {}

//     return CommentModel(
//       id: GlobalEntity.dataFilter(datas['id'].toString()),
//       user: user,
//       comment: GlobalEntity.dataFilter(datas['comment'].toString()),
//       date: date,
//     );
//   }
// }
