import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../../../Core/Widgets/static_bottom_selector.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Controllers/info.dart';
import '../Widgets/dashboard_row_navigator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void dispose() {
    Get.delete<InfoController>();
    super.dispose();
  }

  final InfoController provider = Get.put(InfoController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const MiniMusicPlayerBox(),
        appBar: GlobalAppbar(
          subtitle: 'mange your basic info',
          title: 'Profile',
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(
                  child: LoadingWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => provider.selectImage(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: provider.hasImage.value
                                  ? Image.network(
                                      provider.imageUrl,
                                      height: 165,
                                      width: 165,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/Images/userplaceholder.png',
                                        height: 165,
                                        width: 165,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/Images/userplaceholder.png',
                                      height: 165,
                                      width: 165,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // shrinkWrap: true,
                              // physics:
                              //     const NeverScrollableScrollPhysics(),
                              children: [
                                InputBox(
                                  label: 'Your first name',
                                  controller: provider.fNameCtrl,
                                ),
                                const SizedBox(height: 5),
                                InputBox(
                                  label: 'Your last name',
                                  controller: provider.lNameCtrl,
                                ),
                                const SizedBox(height: 5),
                                InputBox(
                                  label: 'Your cell number',
                                  controller: provider.cellCtrl,
                                  textType: TextInputType.phone,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      InputBox(
                        label: 'Your email address',
                        controller: provider.emailCtrl,
                        textType: TextInputType.emailAddress,
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: StaticBottomSelector(
                              label: 'Country',
                              controller: provider.countryCtrl,
                              datas: provider.countries,
                              function: () async {
                                await provider.getCities();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: StaticBottomSelector(
                              label: 'City',
                              controller: provider.cityCtrl,
                              datas: provider.cities,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SubmitButton(
                        func: () => provider.updateDatas(context),
                        icon: null,
                        title: 'UPDATE DATA',
                      ),
                      const SizedBox(height: 30),
                      const DashboardRowNavigator(
                        title: 'CHANGE PASSWORD',
                        subtitle: 'anything wrong with your old password?',
                        route: Routes.changePass,
                        icon: FlutterIcons.asterisk,
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
