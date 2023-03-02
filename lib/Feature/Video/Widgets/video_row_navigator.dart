// import 'package:flutter/material.dart';

// import '../../../Core/Config/routes.dart';
// import '../../../Core/Widgets/flutter_icons.dart';

// class VideoRowNavigator extends StatelessWidget {
//   const VideoRowNavigator({
//     Key? key,
//     required this.themeData,
//   }) : super(key: key);

//   final TextTheme themeData;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         InkWell(
//           onTap: () => Get.toNamed(Routes.videoDetails),
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(30),
//                 child: Image.asset(
//                   'assets/Images/1.jpg',
//                   fit: BoxFit.fill,
//                   height: 200,
//                   width: double.infinity,
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 right: 10,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 5,
//                     horizontal: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         FlutterIcons.align_right,
//                         size: 12,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         '2',
//                         style: Theme.of(context).textTheme.button,
//                       ),
//                       SizedBox(width: 15),
//                       Icon(
//                         FlutterIcons.comment_alt,
//                         size: 12,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         '2',
//                         style: Theme.of(context).textTheme.button,
//                       ),
//                       SizedBox(width: 15),
//                       Icon(
//                         FlutterIcons.clock_1,
//                         size: 12,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 5),
//                       Text(
//                         '15:30',
//                         style: Theme.of(context).textTheme.button,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 90,
//                 left: MediaQuery.of(context).size.width * 4 / 10,
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(.5),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 23,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           'title',
//           textAlign: TextAlign.start,
//           style: themeData.headline3,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Icon(Icons.person, size: 9, color: Colors.white),
//             SizedBox(width: 3),
//             Text(
//               'user',
//               style: themeData.subtitle2,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
