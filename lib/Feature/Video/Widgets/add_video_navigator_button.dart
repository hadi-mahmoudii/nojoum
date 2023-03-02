// import '../../../Core/Config/routes.dart';
// import 'package:flutter/material.dart';

// class AddVideoNavigator extends StatelessWidget {
//   const AddVideoNavigator({
//     Key? key,
//     required this.themeData,
//   }) : super(key: key);
//   final TextTheme themeData;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => Get.toNamed(Routes.addVideo),
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
//             Icon(Icons.add, color: Colors.white, size: 13),
//             SizedBox(width: 10),
//             Text(
//               'ADD YOUR VIDEO',
//               style: themeData.overline!.copyWith(color: Colors.white),
//             ),
//             Spacer(),
//             Icon(Icons.chevron_right, color: Colors.white, size: 13)
//           ],
//         ),
//       ),
//     );
//   }
// }