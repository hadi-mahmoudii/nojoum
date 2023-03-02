// import 'package:champya/Features/Video/Controllers/details.dart';
// import 'package:flutter/material.dart';

// import '../../../Core/Widgets/comment_box.dart';

// class VideoDetailsTabbar extends StatefulWidget {
//   const VideoDetailsTabbar({
//     Key? key,
//     required this.themeData,
//     required this.provider,
//   }) : super(key: key);

//   final TextTheme themeData;
//   final VideoDetailsProvider provider;
//   @override
//   State<VideoDetailsTabbar> createState() => _VideoDetailsTabbarState();
// }

// class _VideoDetailsTabbarState extends State<VideoDetailsTabbar>
//     with TickerProviderStateMixin {
//   late TabController tabCtrl;
//   int currentTabIndex = 0;
//   @override
//   initState() {
//     super.initState();
//     tabCtrl = TabController(length: 1, vsync: this);
//     // Future.microtask(
//     //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.grey.withOpacity(.7),
//               ),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 // onTap: () {
//                 //   tabCtrl.animateTo(0);
//                 //   setState(() {
//                 //     currentTabIndex = 0;
//                 //   });
//                 // },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         color: currentTabIndex == 0
//                             ? Colors.white
//                             : Colors.transparent,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     'COMMENTS',
//                     style: widget.themeData.headline6!.copyWith(
//                       color: currentTabIndex == 0 ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 2,
//           child: DefaultTabController(
//             length: 1,
//             child: TabBarView(
//               physics: NeverScrollableScrollPhysics(),
//               controller: tabCtrl,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: LayoutBuilder(
//                     builder: (ctx, cons) => ListView.separated(
//                       itemBuilder: (ctx, ind) => CommentBox(
//                         cons: cons,
//                         themeData: widget.themeData,
//                         comment: widget.provider.comments[ind],
//                       ),
//                       separatorBuilder: (ctx, ind) => SizedBox(
//                         height: 20,
//                       ),
//                       itemCount: widget.provider.comments.length,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
