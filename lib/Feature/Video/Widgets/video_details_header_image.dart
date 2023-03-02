// import 'package:flutter/material.dart';

// class VideoDetailsHeaderImage extends StatelessWidget {
//   const VideoDetailsHeaderImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: Image.asset(
//               'assets/Images/1.jpg',
//               fit: BoxFit.fill,
//               height: 200,
//             ),
//           ),
//           Positioned(
//             top: 90,
//             left: MediaQuery.of(context).size.width * 4 / 10,
//             child: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.5),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Icon(
//                 Icons.play_arrow,
//                 color: Colors.white,
//                 size: 23,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }