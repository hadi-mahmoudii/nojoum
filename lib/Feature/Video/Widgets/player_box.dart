// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:nojoum/Core/Widgets/loading.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String? videoLink;
//   final String? imageLink;
//   const VideoPlayerWidget({
//     Key? key,
//     required this.videoLink,
//     this.imageLink,
//   }) : super(key: key);
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late BetterPlayerController _betterPlayerController;
//   Map<String, String> urls = {};
//   bool isInit = true;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() async {
//     if (isInit) {
//       // try {
//       //   var response = await http.get(Uri.parse(widget.videoLink! + '/config'));
//       //   var jsonData =
//       //       jsonDecode(response.body)['request']['files']['progressive'];
//       //   // print(widget.videoLink + '/config');
//       //   for (var data in jsonData) {
//       //     // print(data['url'].toString());
//       //     // print(data['quality'].toString());
//       //     if (data['quality'].toString() == '240p') // 240p have problem
//       //       continue;
//       //     else
//       //       urls[data['quality'].toString()] = data['url'].toString();
//       //     // print(data['url'].toString());
//       //     // print(data['quality'].toString());
//       //   }
//       // } catch (error) {
//       //   print('=====> REQUEST ERROR: $error');
//       // }
//       if (urls.isNotEmpty) {
//         BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//           BetterPlayerDataSourceType.network,
//           widget.videoLink!,
//           // resolutions: urls,
//         );
//         _betterPlayerController = BetterPlayerController(
//           BetterPlayerConfiguration(
//             controlsConfiguration:
//                 BetterPlayerControlsConfiguration(enableProgressText: true),
//             autoDetectFullscreenDeviceOrientation: true,
//             autoPlay: false,
//             errorBuilder: (ctx, _) => Center(
//               child: Text(
//                 'متاسفانه در پخش ویدئو خطایی رخ داده است.',
//                 textDirection: TextDirection.rtl,
//               ),
//             ),
//             allowedScreenSleep: false,
//             showPlaceholderUntilPlay: true,
//             placeholder: Image.network(widget.imageLink!),
//             looping: true,
//             // fullScreenByDefault: true,
//           ),
//           betterPlayerDataSource: betterPlayerDataSource,
//         );
//       }
//       setState(() {
//         isInit = false;
//       });
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isInit
//         ? Center(child: LoadingWidget())
//         : urls.isNotEmpty
//             ? Container(
//                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                 height: 250,
//                 child: BetterPlayer(
//                   controller: _betterPlayerController,
//                 ),
//               )
//             : Center(
//                 child: Text('Error play video'),
//               );
//   }
// }
