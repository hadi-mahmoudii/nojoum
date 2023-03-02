import 'package:nojoum/Core/Models/global.dart';

class StoryModel {
  final String id, image, video;
  final String userId, userImage, userName;
  final int? nextId, previousId;
  StoryModel({
    required this.id,
    required this.image,
    required this.video,
    required this.userId,
    required this.userImage,
    required this.userName,
    this.previousId,
    this.nextId,
  });

  factory StoryModel.fromJson(Map datas) {
    return StoryModel(
      id: GlobalEntity.dataFilter(datas['id'].toString()),
      image: GlobalEntity.dataFilter(datas['video']['thumbnail'].toString()),
      video: GlobalEntity.dataFilter(datas['video']['url'].toString()),
      userId: GlobalEntity.dataFilter(datas['user']['id'].toString()),
      userImage: GlobalEntity.dataFilter(datas['user']['thumbnail'].toString()),
      userName: GlobalEntity.dataFilter(datas['user']['name'].toString()),
      previousId: datas['previous_id'],
      nextId: datas['next_id'],
    );
  }
}
