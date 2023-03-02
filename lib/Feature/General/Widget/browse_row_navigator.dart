import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class BrowseRowNavigator extends StatelessWidget {
  const BrowseRowNavigator({
    Key? key,
    required this.themeData,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.icon,
  }) : super(key: key);

  final TextTheme themeData;
  final String title, subtitle, route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // final liveController = Get.find<LiveVideoController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: () async {
          // await liveController.changeLiveStatus(true);
          Get.toNamed(route);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 31,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: themeData.headline4,
                  ),
                  Text(
                    subtitle,
                    style: themeData.headline6!.copyWith(fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                FlutterIcons.right_chevron,
                size: 23,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
