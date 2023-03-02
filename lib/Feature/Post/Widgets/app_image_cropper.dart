import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/submit_button.dart';
import 'package:path_provider/path_provider.dart';

class APPImageCropper extends StatefulWidget {
  const APPImageCropper({
    ///imageFile
    required this.imageFile,

    ///padding
    this.padding,

    ///buttonLabel
    this.buttonLabel,

    ///cropped
    required this.cropped,

    ///aspectRatio
    this.aspectRatio = 1.7,

    ///key
    final Key? key,
  }) : super(key: key);

  ///the file pick
  final PlatformFile imageFile;

  ///padding
  final EdgeInsets? padding;

  ///After cropping is done, this method calls back a new image
  final Function(PlatformFile imageCroped) cropped;

  ///buttonLabel
  final String? buttonLabel;

  ///aspectRatio
  final double? aspectRatio;

  @override
  APPImageCropperState createState() => APPImageCropperState();
}

class APPImageCropperState extends State<APPImageCropper> {
  late CropController controller;
  double imageheight = 0;
  bool show = false;
  bool defaultSize = true;

  @override
  void initState() {
    controller = CropController(
      aspectRatio: widget.aspectRatio,
      defaultCrop: const Rect.fromLTWH(0.1, 0.1, 0.9, 0.9),
    );
    getImageSized();

    super.initState();
  }

  Future<void> getImageSized() async {
    final decodedImage = await decodeImageFromList(widget.imageFile.bytes!);
    if (decodedImage.height > Get.height - 180) {
      imageheight = Get.height - 180;
      defaultSize = false;
    } else {
      defaultSize = true;
    }
    show = true;
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    return show
        ? SizedBox(
            height: Get.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                if (defaultSize)
                  Padding(
                    padding: widget.padding ?? const EdgeInsets.all(16),
                    child: CropImage(
                      controller: controller,
                      gridCornerSize: 20,
                      image: Image.memory(
                        widget.imageFile.bytes!,
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: imageheight,
                    child: Padding(
                      padding: widget.padding ?? const EdgeInsets.all(16),
                      child: CropImage(
                        controller: controller,
                        image: Image.memory(
                          widget.imageFile.bytes!,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SubmitButton(
                    title: 'Save',
                    func: _finished,
                    icon: null,
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        : Container();
  }


  Future<void> _finished() async {
    final image = await controller.croppedBitmap();
    final data = await image.toByteData(format: ImageByteFormat.png);
    final bytes = data!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final now = DateTime.now();
    final finalCrop = PlatformFile(
      name: '${now.toString()}.png',
      path: '${directory.path}/${now.toString()}.png',
      bytes: bytes,
      size: bytes.lengthInBytes,
    );

    return widget.cropped(finalCrop);
  }
}
