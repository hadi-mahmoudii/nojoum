import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../Model/artist.dart';

class SingerNavigatorRow extends StatelessWidget {
  const SingerNavigatorRow({
    Key? key,
    required this.themeData,
    required this.artist,
  }) : super(key: key);

  final TextTheme themeData;
  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        Routes.singerInfo,
        arguments: artist.id,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        color: Colors.white.withOpacity(.9),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  artist.thumbnail,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, _, __) => Image.asset(
                    'assets/Images/userplaceholder.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                  artist.genreName.isNotEmpty
                      ? Text(
                          artist.genreName.toUpperCase(),
                          style: themeData.headline3!.copyWith(
                            color: const Color(0XFF626262),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                FlutterIcons.right_chevron,
                color: Colors.black,
                size: 25,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
