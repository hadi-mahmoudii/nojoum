import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nojoum/Feature/Video/Controllers/live_screen.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/loading.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  void dispose() {
    Get.delete<LiveScreenVideoController>();
    super.dispose();
  }

  final LiveScreenVideoController provider =
      Get.put(LiveScreenVideoController());

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(
                  child: LoadingWidget(),
                )
              : Center(
                  child: Stack(
                    children: [
                      BetterPlayer(
                        controller: provider.controller,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          color: Colors.black.withOpacity(.7),
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
