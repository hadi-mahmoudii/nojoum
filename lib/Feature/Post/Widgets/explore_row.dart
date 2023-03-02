import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/routes.dart';

import '../Models/story.dart';

class ExploreRowImages extends StatelessWidget {
  const ExploreRowImages({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final List<StoryModel> stories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(builder: (ctx, cons) {
        List<Widget> rowImages = [];
        try {
          rowImages.add(
            InkWell(
              onTap: () => Get.toNamed(
                Routes.showStory,
                arguments: stories[0].id,
              ),
              child: Image.network(
                stories[0].image,
                width: cons.maxWidth / 2 - 2,
                height: double.maxFinite,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/Images/placeholder_.jpg',
                  width: cons.maxWidth / 2 - 2,
                  height: double.maxFinite,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
          rowImages.add(const SizedBox(width: 4));
        } catch (_) {}
        try {
          List<Widget> colImages = [];
          try {
            colImages.add(
              InkWell(
                onTap: () => Get.toNamed(
                  Routes.showStory,
                  arguments: stories[1].id,
                ),
                child: Image.network(
                  stories[1].image,
                  width: cons.maxWidth / 4 - 3,
                  height: Get.height * 1 / 5 - 2,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/Images/placeholder_.jpg',
                    width: cons.maxWidth / 4 - 3,
                    height: Get.height * 1 / 5 - 2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          } catch (_) {}
          try {
            colImages.add(const Spacer());
            colImages.add(
              InkWell(
                onTap: () => Get.toNamed(
                  Routes.showStory,
                  arguments: stories[2].id,
                ),
                child: Image.network(
                  stories[2].image,
                  width: cons.maxWidth / 4 - 3,
                  height: Get.height * 1 / 5 - 2,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/Images/placeholder_.jpg',
                    width: cons.maxWidth / 4 - 3,
                    height: Get.height * 1 / 5 - 2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          } catch (_) {}
          rowImages.add(
            SizedBox(
              height: Get.height * 2 / 5,
              // padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: colImages,
              ),
            ),
          );
          rowImages.add(const SizedBox(width: 4));
        } catch (_) {}
        try {
          List<Widget> colImages = [];
          try {
            colImages.add(
              InkWell(
                onTap: () => Get.toNamed(
                  Routes.showStory,
                  arguments: stories[3].id,
                ),
                child: Image.network(
                  stories[3].image,
                  width: cons.maxWidth / 4 - 3,
                  height: Get.height * 1 / 5 - 2,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/Images/placeholder_.jpg',
                    width: cons.maxWidth / 4 - 3,
                    height: Get.height * 1 / 5 - 2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          } catch (_) {}
          try {
            colImages.add(const Spacer());
            colImages.add(
              InkWell(
                onTap: () => Get.toNamed(
                  Routes.showStory,
                  arguments: stories[4].id,
                ),
                child: Image.network(
                  stories[4].image,
                  width: cons.maxWidth / 4 - 3,
                  height: Get.height * 1 / 5 - 2,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/Images/placeholder_.jpg',
                    width: cons.maxWidth / 4 - 3,
                    height: Get.height * 1 / 5 - 2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          } catch (_) {}
          rowImages.add(
            SizedBox(
              height: Get.height * 2 / 5,
              // padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: colImages,
              ),
            ),
          );
        } catch (_) {}
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          height: Get.height * 2 / 5,
          child: Row(
            children: rowImages,
          ),
        );
      }),
    );
  }
}
