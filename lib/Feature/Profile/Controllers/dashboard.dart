import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../Post/Controllers/explore.dart';
import '../../Post/Controllers/my_feed.dart';

class DashboardController extends GetxController {
  logout(BuildContext context, {bool sendRequest = false}) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.black,
        content: const Text(
          'Are you sure?',
          // textDirection: TextDirection.rtl,
          style: TextStyle(color: mainFontColor),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final prefs = GetStorage();
              prefs.remove('userData');
              var appSession = Get.find<AppSession>();
              appSession.setToken('');

              // Get.offAllNamed(Routes.mainScreen);
              // Get.delete<HomeController>();
              // AppSession.userName = '';
              // AppSession.userPhone = '';

              // final prefs = await SharedPreferences.getInstance();
              // prefs.remove('userData');
              // Navigator.of(context).popUntil((route) => route.isFirst);
              Get.find<AppSession>().changePage(0);
              Get.delete<MyFeedController>();
              Get.delete<ExploreController>();
              Get.offAllNamed(Routes.mainScreen);
              // try {
              //   Get.find<LiveVideoController>().changeLiveStatus(false);
              // } catch (_) {}
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: mainFontColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'No',
              style: TextStyle(color: mainFontColor),
            ),
          ),
        ],
      ),
    );
  }
}
