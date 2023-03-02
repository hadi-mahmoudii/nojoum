import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/app_session.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Feature/Post/Controllers/stories.dart';

class StoryHeaderBox extends StatelessWidget {
  StoryHeaderBox({
    Key? key,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final StoriesController controller = Get.find<StoriesController>();

  @override
  Widget build(BuildContext context) {
    controller.getStories();
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 75,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              if (scrollController.position.pixels >
                  scrollController.position.maxScrollExtent - 30) {
                controller.getStories();
              }
            }
            return true;
          },
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (Get.find<AppSession>().token.isNotEmpty) {
                    Get.toNamed(Routes.captureVideo);
                  } else {
                    Get.toNamed(Routes.login);
                  }
                },
                child: const CircleAvatar(
                  child: Icon(
                    FlutterIcons.plus_linear,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromARGB(255, 75, 72, 72),
                  radius: 35,
                ),
              ),
              const SizedBox(width: 4),
              ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (ctx, index) => InkWell(
                  onTap: () => Get.toNamed(
                    Routes.showStory,
                    arguments: controller.stories[index].id,
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(controller.stories[index].image),
                    radius: 35,
                    backgroundColor: Colors.black26,
                  ),
                ),
                separatorBuilder: (ctx, index) => const SizedBox(width: 4),
                itemCount: controller.stories.length,
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
