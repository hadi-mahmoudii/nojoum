import 'package:nojoum/Core/Models/date_convertor.dart';

import '../../../Core/Models/global.dart';

class PostDetailsModel {
  final String id, url, details, date, image;
  final bool isVideo,isLiked;
  final String userId, userName, userImage, userEmail;
  int totalLike, totalReplay;

  PostDetailsModel({
    required this.id,
    required this.details,
    required this.url,
    required this.date,
    required this.image,
    required this.isVideo,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.totalLike,
    required this.totalReplay,
    required this.isLiked,
  });

  factory PostDetailsModel.fromJson(Map datas) {
    bool isVideo = false;
    try {
      if (datas['file']['mime_type'].toString().contains('video')) {
        isVideo = true;
      }
    } catch (_) {}

    String url = '';
    String image = '';
    try {
      url = GlobalEntity.dataFilter(datas['file']['url'].toString());
      image = GlobalEntity.dataFilter(datas['file']['thumbnail'].toString());
    } catch (_) {}

    String userId = '';
    String userName = '';
    String userEmail = '';
    String userImage = '';
    try {
      userId = GlobalEntity.dataFilter(datas['user']['id'].toString());
      userName = GlobalEntity.dataFilter(datas['user']['name'].toString());
      userEmail = GlobalEntity.dataFilter(datas['user']['email'].toString());
      userImage =
          GlobalEntity.dataFilter(datas['user']['thumbnail'].toString());
    } catch (_) {}
    return PostDetailsModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      details: GlobalEntity.dataFilter(datas['text'].toString()),
      date: DateConvertor.dateFromNow(
          GlobalEntity.dataFilter(datas['created_at'].toString())),
      url: url,
      image: image,
      isVideo: isVideo,
      isLiked: datas['is_liked'],
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userImage: userImage,
      totalLike: datas['likes'],
      totalReplay: datas['comments_count'],
    );
  }
}
