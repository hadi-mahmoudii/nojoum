import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/mini_music_player.dart';
import 'package:nojoum/Core/main_screen.dart';
import 'package:nojoum/Feature/Music/Controllers/details.dart';

import '../../../Core/Config/app_session.dart';
import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Controllers/dashboard.dart';
import '../Widgets/dashboard_row_navigator.dart';
import '../Widgets/logout_button.dart';
import '../Widgets/register_box.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin<DashboardScreen> {
  @override
  void dispose() {
    Get.delete<DashboardController>();
    super.dispose();
  }

  final DashboardController provider = Get.put(DashboardController());
  final appSession = Get.find<AppSession>();
  final musicProvider = Get.find<MusicDetailsController>();

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Scaffold(
      body: FilterWidget(
        child: LayoutBuilder(
          builder: (ctx, cons) => ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Stack(
                children: [
                  appSession.token.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          // shrinkWrap: true,
                          children: [
                            SizedBox(height: Get.mediaQuery.viewPadding.top),
                            const SizedBox(height: 20),
                            // const SizedBox(height: 35),
                            const SimpleHeader(
                              mainHeader: 'DASHBOARD',
                              subHeader: '',
                              showRightAngle: false,
                            ),
                            // const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: const [
                                  DashboardRowNavigator(
                                    title: 'Profile',
                                    subtitle: 'manage your basic info',
                                    icon: FlutterIcons.user_linear,
                                    route: Routes.info,
                                  ),
                                  DashboardRowNavigator(
                                    title: 'MY PLAYLISTS',
                                    subtitle:
                                        'playlists that you like and create',
                                    route: Routes.myPlaylists,
                                    icon: FlutterIcons.playlist_linear,
                                  ),
                                  DashboardRowNavigator(
                                    title: 'MY FAVORITES',
                                    subtitle: 'your favorite songs and videos',
                                    route: Routes.myFavorites,
                                    icon: FlutterIcons.heart_linear,
                                  ),
                                  // DashboardRowNavigator(
                                  //   themeData: themeData,
                                  //   title: 'MY POSTS',
                                  //   subtitle: 'what you shared with others',
                                  //   route: Routes.myFavorites,
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            LogoutButton(
                              themeData: themeData,
                              func: () => provider.logout(context),
                            ),
                            const SizedBox(height: 50),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      FlutterIcons.home_icon,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '''MAKE
YOURSELF
AT HOME''',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        // fontWeight: FontWeight.bold,
                                        height: .95,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 60),
                              Text(
                                '''For accessing your dashboard
please do login or create an account
from links below.''',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: const Color(0XFFAFAFAF)),
                              ),
                              const SizedBox(height: 20),
                              SubmitButton(
                                func: () {
                                  Get.find<MusicDetailsController>().pause();
                                  Get.toNamed(Routes.login);
                                },
                                icon: null,
                                title: 'Login',
                              ),
                              const SizedBox(height: 20),
                              const RegisterNavigatorButton(),
                            ],
                          ),
                        ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GlobalBottomNavigationBar(),
                  ),
                  musicProvider.hasValue.value
                      ? const Positioned(
                          bottom: 75,
                          left: 0,
                          right: 0,
                          child: MiniMusicPlayerBox(),
                        )
                      : Container(),
                ],
              )),
        ),
      ),
    );
  }
}
