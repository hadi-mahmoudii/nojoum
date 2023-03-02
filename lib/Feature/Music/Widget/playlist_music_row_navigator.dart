import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Music/Controllers/playlist_details.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../Controllers/details.dart';
import '../Controllers/music_row.dart';
import '../Model/music.dart';

class PlaylistMusicRowNavigator extends StatefulWidget {
  const PlaylistMusicRowNavigator({
    Key? key,
    required this.themeData,
    required this.music,
    this.letRaplaceRoute = false,
    this.isMyPlaylist = false,
    // this.refteshPageFunction,

    //when use in
  }) : super(key: key);

  final TextTheme themeData;
  final MusicModel music;
  final bool letRaplaceRoute;
  final bool isMyPlaylist;

  @override
  State<PlaylistMusicRowNavigator> createState() =>
      _PlaylistMusicRowNavigatorState();
}

class _PlaylistMusicRowNavigatorState extends State<PlaylistMusicRowNavigator> {
  final AppSession appSession = Get.find<AppSession>();
  final MusicDetailsController provider = Get.find<MusicDetailsController>();
  late MusicRowController musicProvider;
  @override
  void initState() {
    musicProvider =
        Get.put(MusicRowController(widget.music), tag: widget.music.id);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MusicRowController>(tag: widget.music.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> popUps = [
      PopupMenuItem<String>(
        child: Container(
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: Colors.white10,
          ),
          child: const Text(
            'Add to playlist',
          ),
        ),
        onTap: () async {
          var datas = await musicProvider.getPlaylists();
          provider.addDialog(
            context,
            widget.music.id,
            datas,
          );
        },
      ),
      PopupMenuItem<String>(
        child: Container(
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // color: Colors.white10,
          ),
          child: Text(
            musicProvider.isMyFavorite.value
                ? 'Remove from Favorites'
                : 'Add to favorites',
          ),
        ),
        onTap: () {
          provider.changeFavorite(
              widget.music.id, !musicProvider.isMyFavorite.value);
          musicProvider.changeFavorite();
        },
      ),
    ];
    if (widget.isMyPlaylist) {
      popUps.add(
        PopupMenuItem<String>(
          child: Container(
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Colors.white10,
            ),
            child: const Text('Delete from playlist'),
          ),
          onTap: () {
            Get.find<PlaylistDetailsController>().removeFromPlayList(
              widget.music.id,
            );
          },
        ),
      );
    }
    return InkWell(
      onTap: () {
        if (widget.letRaplaceRoute) {
          Get.offNamed(Routes.musicDetails,
              arguments: widget.music.id, preventDuplicates: false);
        } else {
          Get.toNamed(Routes.musicDetails,
              arguments: widget.music.id, preventDuplicates: false);
        }
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Image.network(
            widget.music.thumbnail,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/Images/musicplaceholder.png',
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
        ),
        title: Text(
          widget.music.name,
          style: widget.themeData.headline1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text(
                widget.music.artist.name,
                style: widget.themeData.subtitle2!.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              decoration: BoxDecoration(
                color: const Color(0XFF363636),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                widget.music.length,
                style: widget.themeData.subtitle2,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            )
          ],
        ),
        trailing: appSession.token.isEmpty
            ? IconButton(
                onPressed: () => Get.toNamed(Routes.login),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                itemBuilder: (_) => popUps,
                padding: const EdgeInsets.all(0),
                onSelected: (_) {},
                color: Colors.black,
              ),
      ),
    );
  }
}
