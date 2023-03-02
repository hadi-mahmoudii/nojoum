// import 'package:flutter/material.dart';

// import '../Models/comment.dart';

// class CommentBox extends StatelessWidget {
//   const CommentBox({
//     Key? key,
//     required this.cons,
//     required this.themeData,
//     required this.comment,
//   }) : super(key: key);

//   final BoxConstraints cons;
//   final TextTheme themeData;
//   final CommentModel comment;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         ConstrainedBox(
//           constraints: BoxConstraints(minWidth: cons.maxWidth * 2 / 3),
//           child: Column(
//             children: [
//               Container(
//                 width: cons.maxWidth * 2 / 3,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(15),
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                   border: Border.all(color: Colors.white),
//                 ),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 15,
//                   vertical: 10,
//                 ),
//                 child: Center(
//                   child: Text(
//                     comment.comment,
//                     style: themeData.bodyText1,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5),
//               Container(
//                 width: cons.maxWidth * 2 / 3,
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.watch_later_outlined,
//                       color: Colors.white,
//                       size: 9,
//                     ),
//                     SizedBox(width: 2),
//                     Text(
//                       comment.date.toString().substring(0, 10),
//                       style: themeData.headline5,
//                     ),
//                     // Spacer(),
//                     Expanded(
//                       child: Text(
//                         comment.user,
//                         style: themeData.headline5,
//                         textAlign: TextAlign.end,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
