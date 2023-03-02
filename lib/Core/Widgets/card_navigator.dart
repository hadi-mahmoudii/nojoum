// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Config/app_session.dart';
// import 'flutter_icons.dart';

// class GlobalCardNavigator extends StatelessWidget {
//   const GlobalCardNavigator({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppSession>(
//       builder: (ctx, provider, _) {
//         int cardLength = provider.cardLength;
//         return Stack(
//           children: [
//             Positioned(
//               left: 10,
//               bottom: 0,
//               child: FloatingActionButton(
//                 backgroundColor: mainFontColor,
//                 onPressed: () {
//                   // Get.toNamed(Routes.shopCard);
//                 },
//                 child: const Icon(FlutterIcons.shop_1),
//               ),
//             ),
//             cardLength > 0
//                 ? Positioned(
//                     left: 0,
//                     bottom: 27,
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: mainFontColor,
//                       ),
//                       child: Text(
//                         cardLength.toString(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'pacifico',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         );
//       },
//     );
//   }
// }
