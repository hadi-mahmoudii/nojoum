// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nojoum/Feature/Music/Widget/playlist_box.dart';

// import '../../../Core/Widgets/simple_header.dart';
// import '../../News/Widgets/news_box.dart';
// import '../../Video/Widgets/box_navigator.dart';
// import '../Model/secton.dart';
// import 'banner_row.dart';
// import 'feature_box.dart';
// import 'home_music_card.dart';
// import 'radio_row.dart';

// class SectionBox extends StatelessWidget {
//   const SectionBox({
//     Key? key,
//     required this.section,
//     required this.themeData,
//   }) : super(key: key);
//   final HomeSectionModel section;
//   final TextTheme themeData;

//   @override
//   Widget build(BuildContext context) {
//     Widget sectionWidget = Container();
//     // bool showTitle = true;
//     switch (section.section.type) {
//       case 'music':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: .8,
//                   crossAxisSpacing: 7,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemBuilder: (ctx, ind) => HomeMusicBoxNavigator(
//                   themeData: themeData,
//                   music: section.datas[ind],
//                 ),
//                 itemCount: section.datas.length,
//               ),
//             ),
//           ],
//         );
//         break;
//       case 'video':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 130 / 100,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 15,
//                 ),
//                 itemBuilder: (ctx, ind) => VideoBoxNavigator(
//                   themeData: themeData,
//                   video: section.datas[ind],
//                 ),
//                 itemCount: section.datas.length,
//               ),
//             ),
//           ],
//         );
//         break;
//       case 'featured':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 130 / 100,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 15,
//                 ),
//                 itemBuilder: (ctx, ind) => FeatureBoxNavigator(
//                   themeData: themeData,
//                   feature: section.datas[ind],
//                 ),
//                 itemCount: section.datas.length,
//               ),
//             ),
//           ],
//         );
//         break;
//       case 'placeholder':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 30,
//                 horizontal: 20,
//               ),
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (ctx, ind) =>
//                     BannerRowBox(banner: section.datas[ind]),
//                 separatorBuilder: (ctx, ind) => const SizedBox(height: 5),
//                 itemCount: section.datas.length,
//               ),
//             )
//           ],
//         );
//         break;
//       case 'radio_station':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: .8,
//                   crossAxisSpacing: 7,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemBuilder: (ctx, ind) => RadioRowBox(
//                   themeData: themeData,
//                   radio: section.datas[ind],
//                 ),
//                 itemCount: section.datas.length,
//               ),
//             )
//           ],
//         );
//         break;
//       case 'news':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 30,
//                 horizontal: 20,
//               ),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 130 / 100,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 15,
//                 ),
//                 itemBuilder: (ctx, ind) => NewsNavigatorBox(
//                   themeData: themeData,
//                   news: section.datas[ind],
//                   letRestartLive: false,
//                 ),
//                 itemCount: section.datas.length,
//               ),
//             )
//           ],
//         );
//         break;
//       case 'playlist':
//         sectionWidget = ListView(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             SimpleHeader(
//               mainHeader: section.section.title,
//               subHeader: section.section.subtitle,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 30,
//                 horizontal: 20,
//               ),
//               child: SizedBox(
//                 height: 250,
//                 // width: 500,
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (ctx, ind) => SizedBox(
//                     // height: 250,
//                     width: Get.size.width * 4 / 10,
//                     child: PlayListNavigatorBox(
//                       themeData: themeData,
//                       playlist: section.datas[ind],
//                     ),
//                   ),
//                   separatorBuilder: (ctx, ind) => const SizedBox(width: 15),
//                   itemCount: section.datas.length,
//                 ),
//               ),
//             )
//           ],
//         );
//         break;
//       default:
//     }
//     return sectionWidget;
//   }
// }
