import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';
import 'package:nojoum/Core/Widgets/loading.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
    // required this.cameras,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  @override
  void initState() {
    super.initState();
  }

  bool isInit = true;

  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  List<File> capturedImages = [];

  initializeCamera(int cameraIndex) async {
    setState(() {
      isInit = true;
    });
    cameras = await availableCameras();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    setState(() {
      isInit = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      initializeCamera(selectedCamera); //Initially selectedCamera = 0

    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isInit
            ? const LoadingWidget()
            : FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the Future is complete, display the preview.
                    return SizedBox(
                      height: Get.size.height,
                      child: CameraPreview(
                        _controller,
                        child: Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            color: Colors.black.withOpacity(.5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    FlutterIcons.cancel_1,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await _initializeControllerFuture;
                                    var xFile = await _controller.takePicture();
                                    setState(() {
                                      capturedImages.add(File(xFile.path));
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cameras.length > 1) {
                                      setState(() {
                                        selectedCamera =
                                            selectedCamera == 0 ? 1 : 0;
                                        initializeCamera(selectedCamera);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content:
                                            Text('No secondary camera found'),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.switch_camera_rounded,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     if (capturedImages.isEmpty) return;
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => GalleryScreen(
                                //           images:
                                //               capturedImages.reversed.toList(),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Container(
                                //     height: 60,
                                //     width: 60,
                                //     decoration: BoxDecoration(
                                //       border: Border.all(color: Colors.white),
                                //       image: capturedImages.isNotEmpty
                                //           ? DecorationImage(
                                //               image: FileImage(
                                //                   capturedImages.last),
                                //               fit: BoxFit.cover)
                                //           : null,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Otherwise, display a loading indicator.
                    return const Center(child: LoadingWidget());
                  }
                },
              ),
      ),
    );
  }
}
