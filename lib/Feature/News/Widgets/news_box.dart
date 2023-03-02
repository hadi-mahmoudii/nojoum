import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/routes.dart';
import '../Models/news.dart';

class NewsNavigatorBox extends StatelessWidget {
  final TextTheme themeData;
  final bool letRestartLive;
  final NewsModel news;

  // final ProductOverviewModel? product;
  const NewsNavigatorBox({
    Key? key,
    required this.themeData,
    required this.news,
    this.letRestartLive = true,

    // @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        final imageHeight = cons.maxWidth * 6 / 10;
        // final horizentalPadding = cons.maxWidth / 33;
        return InkWell(
          onTap: () async {
            Get.find<LiveVideoController>().stopLive(false);
            // if (news.musics.isNotEmpty) {
            Get.toNamed(
              Routes.newsDetails,
              arguments: news.id,
              preventDuplicates: false,
            );
            // } else {
            //   Fluttertoast.showToast(msg: 'This news is empty!');
            // }

            // await Provider.of<AppSession>(context, listen: false)
            //     .changeLiveStatus(true);
            // Navigator.of(context)
            //     .pushNamed(
            //   Routes.newsDetails,
            //   arguments: news,
            //   // arguments: news.id,
            // )
            //     .then((value) async {
            //   if (letRestartLive) {
            //     await Provider.of<AppSession>(context, listen: false)
            //         .changeLiveStatus(false);
            //   }
            // });
          },
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        news.thumbnail,
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
                          'assets/Images/newsplaceholder.png',
                          fit: BoxFit.fitWidth,
                          // height: 50,
                        ),
                      ),
                    ),
                  ),
                  news.isExclusive
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
              const SizedBox(height: 5),
              Text(
                news.name,
                maxLines: 2,
                textDirection: TextDirection.rtl,
                style: themeData.subtitle1!.copyWith(
                  fontSize: 9.5,
                  height: 1,
                  fontFamily: 'cairo',
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
            ],
          ),
        );
      },
    );
  }
}
