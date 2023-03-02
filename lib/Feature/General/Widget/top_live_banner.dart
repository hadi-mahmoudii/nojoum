import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';

import '../../Music/Controllers/details.dart';

class TopLiveBanner extends StatelessWidget {
  const TopLiveBanner({
    Key? key,
    required this.liveController,
    required this.musicController,
  }) : super(key: key);

  final LiveVideoController liveController;
  final MusicDetailsController musicController;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget widget;
      if (liveController.isLoading.value) {
        widget = Container(
          color: Colors.black,
          height: 200,
          child: const LoadingWidget(),
        );
      } else {
        widget = liveController.letShowLive.value
            ? liveController.livePlaying.value
                ? Container(
                    height: 200,
                    color: Colors.black,
                    child: Stack(children: [
                      BetterPlayer(
                        controller: liveController.controller,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(5),
                          child: InkWell(
                            onTap: () {
                              liveController.stopLive(true);
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ]),
                  )
                : Center(
                    child: !musicController.hasValue.value
                        ? Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.black,
                            child: IconButton(
                              onPressed: () async {
                                liveController.getLive();
                              },
                              icon: const Icon(
                                Icons.replay,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  )
            : Container();
      }
      return Positioned(top: 0, left: 0, right: 0, child: widget);
    });
  }
}
