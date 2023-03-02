import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'flutter_icons.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextTheme textTheme;
  const GlobalAppbar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.textTheme,
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
    );
  }
}

// Future logout(BuildContext context, {bool sendRequest = false}) async {
//   showDialog(
//     context: context,
//     builder: (ctx) => AlertDialog(
//       content: const Text(
//         'آیا برای خروج اطمینان دارید؟',
//         textDirection: TextDirection.rtl,
//         style: TextStyle(color: mainFontColor),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () async {
//             Navigator.of(ctx).pop();
//             var appSession = Get.find<AppSession>();
//             appSession.setToken('');
//             final prefs = GetStorage();
//             prefs.remove('userData');
//             Navigator.of(context).popUntil((route) => route.isFirst);
//             // Navigator.of(context).pushReplacementNamed(Routes.home);
//           },
//           child: const Text(
//             'بله',
//             style: TextStyle(color: mainFontColor),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(ctx).pop();
//           },
//           child: const Text(
//             'خیر',
//             style: TextStyle(color: mainFontColor),
//           ),
//         ),
//       ],
//     ),
//   );
// }
