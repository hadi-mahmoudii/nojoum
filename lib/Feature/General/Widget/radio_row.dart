import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../Music/Controllers/details.dart';
import '../Model/radio.dart';

class RadioRowBox extends StatelessWidget {
  final TextTheme themeData;
  final RadioModel radio;
  // final ProductOverviewModel? product;
  const RadioRowBox({
    Key? key,
    required this.themeData,
    required this.radio,

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
            Get.find<LiveVideoController>().stopLive(false);
            final musicProvider = Get.find<MusicDetailsController>();
            // var provider = Get.put(RadioDetailsController(radio));
            await musicProvider.fetchData('', false, rad: radio);
            // if (!musicProvider.hasValue.value) {
            //   try {
            //     await liveController.changeLiveStatus(false);
            //   } catch (_) {}
            // }
          },
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: cons.maxWidth,
                child: Image.network(
                  radio.thumbnail,
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
                    'assets/Images/radioplaceholder.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              radio.isLive
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 2,
                      ),
                      child: const Text(
                        '●LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
