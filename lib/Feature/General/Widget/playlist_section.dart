import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/General/Model/secton.dart';

import '../../Music/Widget/playlist_box.dart';

class HomePlayListSection extends StatelessWidget {
  const HomePlayListSection({
    Key? key,
    required this.section,
    required this.themeData,
  }) : super(key: key);

  final HomeSectionModel section;
  final TextTheme themeData;
  @override
  Widget build(BuildContext context) {
    final ScrollController sc = ScrollController();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if (sc.hasClients) {
    //     sc.jumpTo(sc.position.pixels - 20);
    //   }
    // });
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.width * 4 / 10 + 50,
      // width: 500,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 20),
          ListView.builder(
            controller: sc,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx, ind) => section.features[ind].haveError
                ? Container()
                : SizedBox(
                    // height: 250,
                    width: MediaQuery.of(Get.context!).size.width * 4 / 10,
                    child: PlayListNavigatorBox(
                      themeData: themeData,
                      playlist: section.features[ind].data,
                      paddingRight: 14,
                    ),
                  ),
            itemCount: section.features.length,
          ),
        ],
      ),
    );
  }
}