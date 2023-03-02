import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/empty.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Core/Widgets/input_box.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Core/Widgets/submit_button2.dart';
import 'package:nojoum/Feature/Post/Controllers/add.dart';

import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/mini_music_player.dart';

final List<String> imageExtentions = ['jpg', 'png', 'bmp', 'jpeg', 'webp'];

class AddPostScreen extends GetView<AddPostController> {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  String? get tag => Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MiniMusicPlayerBox(),
      appBar: GlobalAppbar(
        subtitle: '',
        title: 'ADD POST',
        textTheme: Get.textTheme,
      ).build(context),
      body: FilterWidget(
        child: controller.obx(
          (datas) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => controller.selectImage(),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0XFF2C2C2C),
                      border: Border.all(
                        color: const Color(0XFF707070),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            FlutterIcons.nojoom_gallery,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '''Choose an image or video
from gallery''',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '''Max size : 30 MB
Max video length : 30 Seconds''',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
                controller.selectedFile.value != null
                    ? imageExtentions
                            .contains(controller.selectedFile.value!.extension)
                        ? Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.memory(
                              controller.selectedFile.value!.bytes!,
                              height: (Get.size.width) - 40,
                              fit: BoxFit.contain,
                              width: (Get.size.width) - 40,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: AspectRatio(
                              aspectRatio: 2,
                              child: BetterPlayer(
                                controller: controller.videoController,
                              ),
                            ),
                          )
                    : Container(),
                const SizedBox(height: 20),
                InputBox(
                  label: 'DESCRIPTION',
                  controller: controller.descCtrl,
                  minLines: 5,
                  maxLines: 10,
                ),
                const SizedBox(height: 30),
                SubmitButton2(
                  func: () => controller.sendPost(),
                  icon: null,
                  title: 'POST',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          onLoading: const LoadingWidget(),
          onEmpty: const Center(
            child: EmptyWidget(),
          ),
          onError: (error) => Center(child: Text(error!)),
        ),
      ),
    );
  }
}
