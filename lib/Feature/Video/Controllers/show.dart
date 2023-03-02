// import 'dart:convert';

// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';

// class ShowVideoProvider extends ChangeNotifier with ReassembleHandler {
//   bool isLoading = true;
//   bool isLoadingMore = false;
//   ScrollController scrollController = ScrollController();
//   final String videoLink;
//   Map<String, String> urls = {};
//   late FlickManager flickManager;

//   late VideoPlayerController controller;

//   ShowVideoProvider(this.videoLink);

//   getDatas(BuildContext context, {bool resetPage = false}) async {
//     try {
//       final String dataLink =
//           'https://player.vimeo.com/video/${videoLink.split('com/')[1]}/config';
//       print(dataLink);
//       var response = await http.get(Uri.parse(dataLink));
//       var jsonData =
//           jsonDecode(response.body)['request']['files']['progressive'];
//       // print(widget.videoLink + '/config');
//       for (var data in jsonData) {
//         // print(data['url'].toString());
//         // print(data['quality'].toString());
//         if (data['quality'].toString() == '240p') {
//           continue;
//         } else {
//           urls[data['quality'].toString()] = data['url'].toString();
//         }
//         // print(data['url'].toString());
//         // print(data['quality'].toString());

//       }
//       if (urls.keys.isNotEmpty) {
//         final String url = urls[urls.keys.first]!;
//         print(url);
//         controller = VideoPlayerController.network(url)
//           ..initialize().then((value) {
//             flickManager = FlickManager(
//               videoPlayerController: controller,
//             );
//             isLoading = false;
//             notifyListeners();
//           });
//       } else {
//         Fluttertoast.showToast(msg: 'Error to get video datas!');
//         Get.back();
//         return;
//       }
//     } catch (error) {
//       print('=====> REQUEST ERROR: $error');
//       Fluttertoast.showToast(msg: 'Error to get video datas!');
//       Get.back();
//     }
//   }

//   @override
//   void dispose() async {
//     await flickManager.dispose();
//     // await controller.dispose();
//     super.dispose();
//   }

//   @override
//   void reassemble() {}
// }
