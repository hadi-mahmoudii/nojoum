import 'package:get/get.dart';
import 'package:nojoum/Feature/Music/Controllers/playlist_details.dart';
import 'package:nojoum/Feature/News/Controllers/news_details.dart';
import 'package:nojoum/Feature/Post/Controllers/my_feed.dart';
import 'package:nojoum/Feature/Post/Controllers/stories.dart';
import 'package:nojoum/Feature/Reaction/Controllers/reaction.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';

import '../../Feature/Music/Controllers/details.dart';
import '../../Feature/Post/Controllers/explore.dart';
import '../Config/app_session.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFeedController>(
      () => MyFeedController(),
      fenix: true,
    );
    Get.put(AppSession());
    Get.put(MusicDetailsController());
    Get.put(StoriesController());
    Get.put(LiveVideoController(),permanent: true);
    Get.lazyPut<ExploreController>(() => ExploreController());
    Get.lazyPut<ReactionController>(() => ReactionController());
    Get.lazyPut<PlaylistDetailsController>(
      () => PlaylistDetailsController(),
      fenix: true,
    );
    Get.lazyPut<NewsDetailsController>(
      () => NewsDetailsController(),
      fenix: true,
    );
  }
}
