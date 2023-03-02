import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'flutter_icons.dart';

class GlobalAddableAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextTheme textTheme;
  final Function func;
  const GlobalAddableAppbar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.textTheme,
    required this.func,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          FlutterIcons.left_chevron,
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: false,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.headline5,
          ),
          subtitle.isNotEmpty
              ? Text(
                  subtitle.toUpperCase(),
                  style: textTheme.headline6,
                )
              : Container(),
        ],
      ),
      actions: [
        InkWell(
          onTap: () => func(),
          child: const Icon(
            FlutterIcons.plus_linear,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
