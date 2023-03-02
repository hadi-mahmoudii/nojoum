import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../Music/Model/music.dart';

class HomeMusicBoxNavigator extends StatelessWidget {
  final TextTheme themeData;
  final MusicModel music;
  // final ProductOverviewModel? product;
  const HomeMusicBoxNavigator({
    Key? key,
    required this.themeData,
    required this.music,

    // @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final liveController = Get.find<LiveVideoController>();
    return LayoutBuilder(
      builder: (ctx, cons) {
        // final imageHeight = cons.maxWidth * 55 / 100;
        // final horizentalPadding = cons.maxWidth / 33;
        return InkWell(
          onTap: () async {
            // await liveController.changeLiveStatus(true);
            Get.find<LiveVideoController>().stopLive(false);
            Get.toNamed(
              Routes.musicDetails,
              arguments: music.id,
              // arguments: video.id,
            )!
                .then((value) async {
              // final musicProvider = Get.find<MusicDetailsController>();
              // if (!musicProvider.hasValue.value) {
              //   try {
              //     await liveController.changeLiveStatus(false);
              //   } catch (_) {}
              // }
            });
          },
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: cons.maxWidth,
                    child: Image.network(
                      music.thumbnail,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Skeleton(
                            height: (Get.size.width) / 4,
                            width: (Get.size.width) / 4,
                            padding: 5,
                            borderRadius: BorderRadius.circular(5),
                          );
                        }
                      },
                      errorBuilder: (ctx, _, __) => Image.asset(
                        'assets/Images/musicplaceholder.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  music.isExclusive
                      ? Positioned(
                          top: 3,
                          right: 3,
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
                          music.name,
                          maxLines: 1,
                          style: themeData.caption!.copyWith(fontSize: 9.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: cons.maxWidth * 3 / 5),
                              child: Text(
                                music.artist.name,
                                style: themeData.subtitle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Spacer(),
                  Column(
                    children: [
                      const Icon(
                        FlutterIcons.music,
                        color: Colors.white54,
                        size: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          music.playCount,
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
