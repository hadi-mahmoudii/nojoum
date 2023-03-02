// import 'package:flutter/material.dart';

// class VideosFiltersNavigator extends StatelessWidget {
//   const VideosFiltersNavigator({
//     Key? key,
//     required this.themeData,
//   }) : super(key: key);
//   final TextTheme themeData;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 5),
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.white54),
//             bottom: BorderSide(color: Colors.white54),
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.filter_alt,
//               color: Colors.white,
//               size: 13,
//             ),
//             SizedBox(width: 10),
//             Text(
//               'FILTERS',
//               style: themeData.overline!.copyWith(color: Colors.white),
//             ),
//             Spacer(),
//             Icon(Icons.close, color: Colors.white, size: 13)
//           ],
//         ),
//       ),
//     );
//   }
// }
