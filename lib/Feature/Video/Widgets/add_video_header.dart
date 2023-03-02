// import 'package:flutter/material.dart';

// import '../Controllers/add.dart';

// class AddVideoHeader extends StatelessWidget {
//   const AddVideoHeader({
//     Key? key,
//     required this.provider,
//     required this.themeData,
//   }) : super(key: key);
//   final AddVideoProvider provider;
//   final TextTheme themeData;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async => await provider.selectImage(),
//       child: Stack(
//         children: [
//           provider.hasImage
//               ? ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Image.asset(
//                     'assets/Images/1.jpg',
//                     fit: BoxFit.fill,
//                     height: 200,
//                   ),
//                 )
//               : Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//           Positioned(
//             top: 80,
//             left: MediaQuery.of(context).size.width * 15 / 100,
//             child: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(.5),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.cloud, color: Colors.white, size: 39),
//                   SizedBox(width: 5),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'UPLOAD ZONE',
//                         style: themeData.overline!.copyWith(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         ' Max file size: 50MB\n File Type: MP4',
//                         style: themeData.bodyText1,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
