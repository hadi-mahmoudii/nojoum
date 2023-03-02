import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Feature/Music/Model/playling_type.dart';
import '../../Feature/Music/Controllers/details.dart';
import '../Config/routes.dart';
import 'flutter_icons.dart';
import 'loading.dart';

class MiniMusicPlayerBox extends StatelessWidget {
  const MiniMusicPlayerBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final musicProvider = Get.find<MusicDetailsController>();
    // final TextTheme themeData = Theme.of(context).textTheme;
    return Obx(() {
      late Widget mainButton;

      try {
        switch (musicProvider.buttonState.value) {
          case ButtonState.loading:
            mainButton = const LoadingWidget();
            break;
          case ButtonState.idle:
            mainButton = Container();
            break;
          case ButtonState.paused:
            mainButton = IconButton(
              icon: const Icon(
                FlutterIcons.play_1,
                color: Colors.white70,
                size: 15,
              ),
              // iconSize: 32.0,
              onPressed: () => musicProvider.play(),
            );
            break;
          case ButtonState.playing:
            mainButton = IconButton(
              icon: const Icon(
                FlutterIcons.pause,
                color: Colors.white70,
                size: 15,
              ),
              // iconSize: 32.0,
              onPressed: () => musicProvider.pause(),
            );
            break;
          default:
            mainButton = Container();
        }
      } catch (e) {
        mainButton = Container();
      }

      // if (musicProvider.audioPlayer.playing) {
      // } else {

      // }
      return musicProvider.hasValue.value
          ? Dismissible(
              key: const Key('1'),
              onDismissed: (value) async {
                await musicProvider.resetMusicDatas();
              },
              child: musicProvider.typeIsMusic.value
                  ? InkWell(
                      onTap: () => musicProvider.typeIsMusic.value
                          ? Get.toNamed(Routes.musicDetails, arguments: '0')
                          : () {},
                      child: Container(
                        color: Colors.transparent.withOpacity(.5),
                        height: 60,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 30.0,
                              sigmaY: 30.0,
                            ),
                            child: ListTile(
                              dense: true,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.network(
                                  musicProvider.music.thumbnail,
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    FlutterIcons.music,
                                    size: 25,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              title: Text(
                                musicProvider.music.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                musicProvider.music.artist.name,
                                style: const TextStyle(
                                  color: Color(0XFFB9B9B9),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                              ),
                              trailing: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        FlutterIcons.fast_bw,
                                        color: Colors.white70,
                                        size: 15,
                                      ),
                                      iconSize: 15.0,
                                      onPressed: () =>
                                          musicProvider.letPreviousMusic.value
                                              ? musicProvider.getPreviousMusic()
                                              : null,
                                    ),
                                    mainButton,
                                    IconButton(
                                      icon: const Icon(
                                        FlutterIcons.fast_fw,
                                        color: Colors.white70,
                                        size: 15,
                                      ),
                                      iconSize: 15.0,
                                      onPressed: () =>
                                          musicProvider.letNextMusic.value
                                              ? musicProvider.getNextMusic()
                                              : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => Get.toNamed(
                        Routes.radioDetails,
                        arguments: musicProvider.radio,
                      ),
                      child: Container(
                        color: Colors.transparent.withOpacity(.5),
                        height: 60,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 30.0,
                              sigmaY: 30.0,
                            ),
                            child: ListTile(
                              dense: true,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.network(
                                  musicProvider.radio.thumbnail,
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    FlutterIcons.music,
                                    size: 25,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              title: Text(
                                musicProvider.radio.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                              ),
                              subtitle: const Text(
                                'LISTEN TO THE RADIO',
                                style: TextStyle(
                                  color: Color(0XFFB9B9B9),
                                  fontSize: 9,
                                ),
                                maxLines: 2,
                              ),
                              trailing: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    mainButton,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            )
          : const SizedBox(
              height: 0,
              width: 0,
            );
    });
  }
}
