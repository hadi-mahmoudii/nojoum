import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../Widgets/app_image_cropper.dart';

class CropperPage extends StatelessWidget {
  const CropperPage({
    required this.title,
    required this.imageFile,
    required this.cropped,
    this.circle = false,
    this.aspectRatio = 1,
    final Key? key,
  }) : super(key: key);

  ///titele of page
  final String title;

  ///the file pick
  final PlatformFile imageFile;

  /// circle type cropper
  final bool circle;

  ///After cropping is done, this method calls back a new image
  final Function(PlatformFile imageCroped) cropped;

  ///aspectRatio
  final double aspectRatio;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          APPImageCropper(
            imageFile: imageFile,
            cropped: cropped,
            aspectRatio: aspectRatio,
          ),
        ],
      ),
    );
  }
}
