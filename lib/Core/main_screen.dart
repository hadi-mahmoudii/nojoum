import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:nojoum/Feature/General/Screen/home.dart';
import 'package:nojoum/Feature/Post/Screens/explore.dart';
import 'package:nojoum/Feature/Post/Screens/my_feed.dart';
import 'package:nojoum/Feature/Video/Controllers/live.dart';

import '../Feature/General/Screen/browse.dart';
import '../Feature/Music/Controllers/details.dart';
import '../Feature/Profile/Screens/dashboard.dart';
import 'Config/app_session.dart';
import 'Config/routes.dart';
import 'Widgets/flutter_icons.dart';
import 'Widgets/loading.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

  bool isInit = true;
  bool isLoggedIn = false;
  // int _selectedIndex = 0;
  // PageController pgCtrl = PageController();
  final appSession = Get.find<AppSession>();
  final musicProvider = Get.find<MusicDetailsController>();

  @override
  void didChangeDependencies() async {
    if (isInit) {
      // AdiveryPlugin.initialize('44cd3183-7c05-47c7-a5d3-518c9d7f4a2a');
      // AdiveryPlugin.setLoggingEnabled(true);
      await appSession.tryAutoLogin(context);
      // isLoggedIn = await provider.initialApp(context);
      // await Provider.of<QueueProvider>(context, listen: false).tryResumeGame();
      setState(() {
        isInit = false;
      });
    }
    super.didChangeDependencies();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again . . .');
      return Future.value(false);
    }
    MoveToBackground.moveTaskToBack();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return isInit
        ? const Center(
            child: LoadingWidget(),
          )
        : WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              key: scaffoldKey,
              // bottomNavigationBar: const GlobalBottomNavigationBar(),
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) async {
                  if (index > 4) {
                    return;
                  }
                  // if (index == 0) {
                  //   if (!musicProvider.hasValue.value) {
                  //     try {
                  //       final liveController = Get.find<LiveVideoController>();
                  //       await liveController.changeLiveStatus(false);
                  //     } catch (_) {
                  //       final liveController = Get.put(LiveVideoController());
                  //       await liveController.changeLiveStatus(false);
                  //     }
                  //   }
                  // } else {
                  //   try {
                  //     final liveController = Get.find<LiveVideoController>();
                  //     await liveController.changeLiveStatus(true);
                  //   } catch (_) {}
                  // }

                  appSession.changePage(index);
                },
                children: const [
                  HomeScreen(),
                  BrowseScreen(),
                  MyFeedScreen(),
                  ExploreScreen(),
                  DashboardScreen(),
                ],
                controller: appSession.pgCtrl,
              ),
            ),
          );
  }
}

class GlobalBottomNavigationBar extends StatelessWidget {
  const GlobalBottomNavigationBar({
    Key? key,
    // required this.musicProvider,
    // required int selectedIndex,
    // required this.pgCtrl,
  }) : super(key: key);

  // final MusicDetailsController musicProvider;
  // final int _selectedIndex;
  // final PageController pgCtrl;

  @override
  Widget build(BuildContext context) {
    final appSession = Get.find<AppSession>();
    return Obx(
      () => Container(
        color: Colors.transparent.withOpacity(.5),
        height: 70,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30.0,
              sigmaY: 30.0,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              selectedItemColor: mainFontColor,
              unselectedItemColor: mainFontColor.withOpacity(.5),
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: appSession.selectedPage.value,
              onTap: (index) {
                // if (index == 2) {
                //   launch('https://nojoumtv.com/ar/');
                //   return;
                // }
                if (index == 1 || index == 3 || index == 4) {
                  Get.find<LiveVideoController>().stopLive(false);
                }
                if (index == 3) {
                  Get.toNamed(Routes.searchMedia);
                  return;
                }
                appSession.pgCtrl.jumpToPage(index);
              },
              elevation: 10,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.nojoom_home),
                  label: 'HOME',
                  backgroundColor: Colors.transparent,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.nojoom_music),
                  label: 'BROWSE',
                  backgroundColor: Colors.transparent,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.nojoom_chat),
                  label: 'CHAT',
                  backgroundColor: Colors.transparent,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(FlutterIcons.compass_light),
                  label: 'SEARCH',
                  backgroundColor: Colors.transparent,
                ),
                BottomNavigationBarItem(
                  icon: appSession.token.isEmpty
                      ? const Icon(FlutterIcons.nojoom_user)
                      : Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              appSession.image,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, _, __) => Image.asset(
                                'assets/Images/userplaceholder.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  label: 'PROFILE',
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
