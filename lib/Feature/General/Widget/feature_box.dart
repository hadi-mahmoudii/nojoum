import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../Video/Controllers/live.dart';
import '../Model/features.dart';

class FeatureBoxNavigator extends StatelessWidget {
  final TextTheme themeData;
  final bool showDuration;
  final FeaturedModel feature;

  // final ProductOverviewModel? product;
  const FeatureBoxNavigator({
    Key? key,
    required this.themeData,
    required this.feature,
    this.showDuration = true,
    // @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final liveController = Get.find<LiveVideoController>();
    bool isExclusive = false;
    try {
      isExclusive = feature.media.isExclusive;
    } catch (_) {}
    return LayoutBuilder(
      builder: (ctx, cons) {
        final imageHeight = cons.maxWidth * 55 / 100;
        // final horizentalPadding = cons.maxWidth / 33;
        return InkWell(
          onTap: () async {
            Get.find<LiveVideoController>().stopLive(false);
            Get.toNamed(
              feature.route,
              arguments: feature.media.id,
            );

            // if (feature.featureType == 'video') {
            //   Get.toNamed(
            //     Routes.videoDetails,
            //     arguments: feature.media.id,
            //     // arguments: video.id,
            //   )!
            //       .then((value) async {
            //     final musicProvider = Get.find<MusicDetailsController>();
            //     if (!musicProvider.hasValue.value) {
            //       try {
            //         await liveController.changeLiveStatus(false);
            //       } catch (_) {}
            //     }
            //   });
            // } else {
            //   Get.toNamed(
            //     Routes.musicDetails,
            //     arguments: feature.media.id,
            //     // arguments: video.id,
            //   );
            // }
          },
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: Image.network(
                      feature.thumbnail,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Skeleton(
                            height: (Get.size.width) / 4,
                            width: (Get.size.width) / 2,
                            padding: 0,
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
                  isExclusive
                      ? Positioned(
                          top: 3,
                          right: 5,
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

              // Container(
              //   height: imageHeight,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(5),
              //     child: Image.network(
              //       product!.image,
              //       fit: BoxFit.cover,
              //       errorBuilder: (ctx, _, __) => Image.asset(
              //         'assets/Images/placeholder.png',
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.media.name,
                          maxLines: 1,
                          style: themeData.caption,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            feature.media.artist.name.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    constraints: BoxConstraints(
                                        maxWidth: cons.maxWidth * 3 / 5),
                                    child: Text(
                                      feature.media.artist.name,
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
                                      feature.media.length,
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
                  Icon(
                    feature.icon,
                    color: Colors.white,
                    size: 11,
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
