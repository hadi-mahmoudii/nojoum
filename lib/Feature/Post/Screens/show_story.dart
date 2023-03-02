import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/empty.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Feature/Post/Controllers/show_story.dart';

import '../../../Core/Widgets/loading.dart';

class ShowStoryScreen extends GetView<ShowStoryController> {
  const ShowStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (story) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  FlutterIcons.left_chevron,
                ),
              ),
              Container(
                height: 35,
                width: 35,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    story!.userImage,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, _, __) => Image.asset(
                      'assets/Images/userplaceholder.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(story.userName),
            ],
          ),
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black26,
        ),
        extendBodyBehindAppBar: true,
        body: SizedBox(
          height: Get.size.height,
          child: Stack(
            children: [
              BetterPlayer(
                controller: controller.videoController,
              ),
              Visibility(
                visible: story.nextId != null ? true : false,
                child: Positioned(
                  bottom: Get.height / 2,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.getData(story.nextId.toString());
                      },
                      child: const Icon(
                        FlutterIcons.right_chevron,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: story.previousId != null ? true : false,
                child: Positioned(
                  bottom: Get.height / 2,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.getData(story.previousId.toString());
                      },
                      child: const Icon(
                        FlutterIcons.left_chevron,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onLoading: const LoadingWidget(),
      onEmpty: const Center(
        child: EmptyWidget(),
      ),
      onError: (error) => Center(child: Text(error!)),
    );
  }
}
