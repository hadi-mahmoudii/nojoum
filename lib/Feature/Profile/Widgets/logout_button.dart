import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.themeData,
    required this.func,
  }) : super(key: key);

  final TextTheme themeData;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => func(),
      child: Container(
        width: 75,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white70,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FlutterIcons.power_linear,
              color: Colors.white,
              size: 15,
            ),
            const SizedBox(width: 5),
            Text(
              'LOG OUT',
              style: themeData.caption,
            ),
          ],
        ),
      ),
    );
  }
}
