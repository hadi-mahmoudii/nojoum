import 'package:get/get.dart';
import 'package:nojoum/Feature/Post/Controllers/details.dart';

class PostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailsController>(() => PostDetailsController());
  }
}
