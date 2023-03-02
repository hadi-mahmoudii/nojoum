import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/banner.dart';

class BannerRowBox extends StatelessWidget {
  const BannerRowBox({
    Key? key,
    required this.banner,
  }) : super(key: key);
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    // String route = '';
    // switch (banner.contentType) {
    //   case 'music':
    //     route = Routes.musicDetails;
    //     break;
    //   case 'video':
    //     route = Routes.videoDetails;
    //     break;
    //   default:
    // }
    // final liveController = Get.find<LiveVideoController>();
    return InkWell(
      onTap: () async {
        Get.find<LiveVideoController>().stopLive(false);
        if (banner.link.isNotEmpty) {
          try {
            launch(banner.link);
            return;
          } catch (_) {}
        }
        try {
          if (banner.route.isNotEmpty) {
            Get.toNamed(
              banner.route,
              arguments: banner.media.id,
            );
          }
        } catch (_) {}
      },
      child: Image.network(
        banner.thumbnail,
        height: (Get.size.width) / 3,
        width: double.maxFinite,
        fit: BoxFit.contain,
        loadingBuilder: (ctx, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Skeleton(
              height: (Get.size.width) / 3,
              width: double.maxFinite,
              padding: 0,
              borderRadius: BorderRadius.circular(5),
            );
          }
        },
        errorBuilder: (ctx, _, __) => Image.asset(
          'assets/Images/videoplaceholder.png',
          height: (Get.size.width) / 3,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
