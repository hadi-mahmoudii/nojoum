import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Models/video.dart';

class VideoBoxNavigator extends StatelessWidget {
  final TextTheme themeData;
  final bool showDuration, letRestartLive;
  final VideoModel video;
  final bool replaceRoute;
  // final ProductOverviewModel? product;
  const VideoBoxNavigator({
    Key? key,
    required this.themeData,
    required this.video,
    this.showDuration = true,
    this.letRestartLive = true,
    this.replaceRoute = false,

    // @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final liveController = Get.find<LiveVideoController>();
    return LayoutBuilder(
      builder: (ctx, cons) {
        final imageHeight = cons.maxWidth * 55 / 100;
        // final horizentalPadding = cons.maxWidth / 33;
        return InkWell(
          onTap: () async {
            Get.find<LiveVideoController>().stopLive(false);
            if (replaceRoute) {
              Get.offNamed(
                Routes.videoDetails,
                arguments: video.id,
                preventDuplicates: false,
                // arguments: video.id,
              )!
                  .then((value) async {
                if (letRestartLive) {
                  // final musicProvider = Get.find<MusicDetailsController>();
                  // if (!musicProvider.hasValue.value) {
                  //   try {
                  //     await liveController.changeLiveStatus(false);
                  //   } catch (_) {}
                  // }
                }
              });
            } else {
              Get.toNamed(
                Routes.videoDetails,
                arguments: video.id,
                preventDuplicates: false,
                // arguments: video.id,
              )!
                  .then((value) async {
                // if (letRestartLive) {
                // final musicProvider = Get.find<MusicDetailsController>();
                // if (!musicProvider.hasValue.value) {
                //   try {
                //     await liveController.changeLiveStatus(false);
                //   } catch (_) {}
                // }
                // }
              });
            }
          },
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: Image.network(
                      video.thumbnail,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Skeleton(
                            height: imageHeight,
                            width: (Get.size.width) / 4,
                            padding: 5,
                            borderRadius: BorderRadius.circular(5),
                          );
                        }
                      },
                      errorBuilder: (ctx, _, __) => Image.asset(
                        'assets/Images/videoplaceholder.png',
                        fit: BoxFit.contain,
                        height: 50,
                      ),
                    ),
                  ),
                  video.isExclusive
                      ? Positioned(
                          top: 3,
                          right: 6,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 2,
                            ),
                            child: const Text(
                              'EXCLUSIVE',
                              style: TextStyle(
                                color: Color(0XFF1AEECA),
                                fontSize: 9,
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.name,
                          maxLines: 1,
                          style: themeData.caption!.copyWith(fontSize: 9.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            video.artist.name.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    constraints: BoxConstraints(
                                        maxWidth: cons.maxWidth * 3 / 5),
                                    child: Text(
                                      video.artist.name,
                                      style: themeData.subtitle2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : Container(),
                            // const SizedBox(width: 10),
                            showDuration
                                ? Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0XFF363636),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      video.length,
                                      style: themeData.subtitle2,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  )
                                : Container()
                          ],
                        )
                      ],
                    ),
                  ),
                  // Spacer(),
                  Column(
                    children: [
                      const Icon(
                        FlutterIcons.play,
                        color: Colors.white54,
                        size: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          video.playCount,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}
