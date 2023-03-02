// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../Core/Widgets/back_button.dart';
// import '../../../Core/Widgets/champya_header.dart';
// import '../../../Core/Widgets/filter.dart';
// import '../../../Core/Widgets/loading.dart';
// import '../../../Core/Widgets/simple_header.dart';
// import '../Controllers/show.dart';

// class ShowVideoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ShowVideoProvider>(
//       create: (ctx) => ShowVideoProvider(
//           ModalRoute.of(context)!.settings.arguments as String),
//       child: ShowVideoScreenTile(),
//     );
//   }
// }

// class ShowVideoScreenTile extends StatefulWidget {
//   const ShowVideoScreenTile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ShowVideoScreenTileState createState() => _ShowVideoScreenTileState();
// }

// class _ShowVideoScreenTileState extends State<ShowVideoScreenTile> {
//   @override
//   initState() {
//     super.initState();
//     Future.microtask(
//       () => Provider.of<ShowVideoProvider>(context, listen: false)
//           .getDatas(context),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final themeData = Theme.of(context).textTheme;
//     return Consumer<ShowVideoProvider>(
//       builder: (ctx, provider, _) => Scaffold(
//         body: FilterWidget(
//           imagePath: 'assets/Images/image2.jpg',
//           child: provider.isLoading
//               ? Center(
//                   child: LoadingWidget(),
//                 )
//               : RefreshIndicator(
//                   onRefresh: () async => print('object'),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: ListView(
//                       children: [
//                         ChampyaHeader(),
//                         SizedBox(height: 15),
//                         GlobalBackButton(title: 'Back'),
//                         SimpleHeader(
//                           mainHeader: 'VIDEO',
//                           subHeader: '',
//                         ),
//                         SizedBox(height: 25),
//                         AspectRatio(
//                           aspectRatio: 2,
//                           child: FlickVideoPlayer(
//                             flickManager: provider.flickManager,
//                           ),
//                         ),
//                         SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
