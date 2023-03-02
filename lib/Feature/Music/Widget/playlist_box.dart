import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../Profile/Controllers/my_playlists.dart';
import '../Model/playlist.dart';

class PlayListNavigatorBox extends StatelessWidget {
  final TextTheme themeData;
  final bool showDuration, letRestartLive;
  final PlayListModel playlist;
  final bool isMyPlaylist;
  final double paddingRight;

  // final ProductOverviewModel? product;
  const PlayListNavigatorBox({
    Key? key,
    required this.themeData,
    required this.playlist,
    this.showDuration = true,
    this.letRestartLive = true,
    this.isMyPlaylist = false,
    this.paddingRight = 0,
    // @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, cons) {
        final imageHeight = cons.maxWidth;
        // final horizentalPadding = cons.maxWidth / 33;
        return Container(
          margin: EdgeInsets.only(right: paddingRight),
          child: InkWell(
            onTap: () async {
              Get.find<LiveVideoController>().stopLive(false);
              Get.toNamed(Routes.playlistDetails,
                  arguments: [playlist.id, isMyPlaylist]);
            },
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: imageHeight,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      playlist.thumbnail,
                      fit: BoxFit.contain,
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
                        'assets/Images/playlistplaceholder.png',
                        fit: BoxFit.contain,
                        // height: 50,
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        playlist.name,
                        maxLines: 1,
                        style: themeData.subtitle1!.copyWith(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Spacer(),
                    isMyPlaylist
                        ? Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: InkWell(
                              onTap: () =>
                                  Get.find<MyPlaylistsController>().delete(
                                context,
                                playlist.id,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          )
                        : Container(),
                    const Icon(
                      FlutterIcons.playlist,
                      color: Colors.white,
                      size: 11,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }
}
