import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Feature/General/Model/secton.dart';

import '../../Video/Controllers/live.dart';

class HomeArtistSection extends StatelessWidget {
  const HomeArtistSection({
    Key? key,
    required this.section,
    required this.themeData,
  }) : super(key: key);

  final HomeSectionModel section;
  final TextTheme themeData;
  @override
  Widget build(BuildContext context) {
    final ScrollController sc = ScrollController();
    return SizedBox(
      height: MediaQuery.of(Get.context!).size.width * 2 / 10 + 50,
      // width: 500,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 20),
          ListView.separated(
            controller: sc,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (ctx, ind) => const SizedBox(width: 10),
            itemBuilder: (ctx, ind) => section.features[ind].haveError
                ? Container()
                : InkWell(
                    onTap: () {
                      Get.find<LiveVideoController>().stopLive(false);
                      Get.toNamed(
                        Routes.singerInfo,
                        arguments: section.features[ind].data.id,
                      );
                    },
                    child: SizedBox(
                      // height: 250,
                      // width: MediaQuery.of(Get.context!).size.width * 2 / 10,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                section.features[ind].data.thumbnail,
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
                          const SizedBox(height: 5),
                          Text(
                            section.features[ind].data.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'montserratlight',
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
            itemCount: section.features.length,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
