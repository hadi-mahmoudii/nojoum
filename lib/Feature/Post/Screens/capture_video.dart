import 'package:better_player/better_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/loading.dart';
import 'package:nojoum/Feature/Post/Controllers/stories.dart';

import '../../Music/Controllers/details.dart';

class CaptureVideoScreen extends StatefulWidget {
  const CaptureVideoScreen({
    Key? key,
    // required this.cameras,
  }) : super(key: key);

  @override
  _CaptureVideoScreenState createState() => _CaptureVideoScreenState();
}

class _CaptureVideoScreenState extends State<CaptureVideoScreen> {
  List<CameraDescription> cameras = [];
  @override
  void initState() {
    try {
      Get.find<MusicDetailsController>().resetMusicDatas();
    } catch (_) {}
    super.initState();
  }

  bool isInit = true;

  late CameraController _controller; //To control the camera
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;

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

  bool _isRecording = false;

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
                                    Icons.switch_camera,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_isRecording) {
                                      final file = await _controller
                                          .stopVideoRecording();
                                      setState(() => _isRecording = false);
                                      final route = MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => VideoPage(file: file),
                                      );
                                      Navigator.push(context, route);
                                    } else {
                                      await _controller
                                          .prepareForVideoRecording();
                                      await _controller.startVideoRecording();
                                      setState(() => _isRecording = true);
                                    }
                                    // await _initializeControllerFuture;
                                    // var xFile = await _controller.takePicture();
                                    // setState(() {
                                    //   capturedImages.add(File(xFile.path));
                                    // });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      _isRecording
                                          ? Icons.check
                                          : Icons.circle_outlined,
                                      color: const Color.fromARGB(
                                          171, 129, 15, 25),
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 5,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Select 9/16 aspect ratio video',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var selectedImage = await Get.find<
                                                  StoriesController>()
                                              .selectImage();
                                          if (selectedImage.isNotEmpty) {
                                            XFile file = XFile(selectedImage);
                                            final route = MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (_) =>
                                                  VideoPage(file: file),
                                            );
                                            Navigator.push(context, route);
                                          }
                                        },
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

class VideoPage extends StatefulWidget {
  final XFile file;

  const VideoPage({Key? key, required this.file}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late BetterPlayerController videoController;

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      // aspectRatio: Get.size.width / Get.size.height,
      aspectRatio: 9 / 16,
      deviceOrientationsOnFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
      looping: true,
      // expandToFill: true,
      autoPlay: true,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        showControls: false,
      ),
    );
    videoController = BetterPlayerController(betterPlayerConfiguration);

    BetterPlayerDataSource dataSource = BetterPlayerDataSource.memory(
      await widget.file.readAsBytes(),
      videoExtension: widget.file.mimeType ?? 'Mp4',
    );
    videoController.setupDataSource(dataSource);
    // await videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              videoController.pause();
              Get.find<StoriesController>().sendStory(widget.file);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingWidget());
          } else {
            return BetterPlayer(
              controller: videoController,
            );
          }
        },
      ),
    );
  }
}
