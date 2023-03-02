// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../Core/Widgets/back_button.dart';
// import '../../../Core/Widgets/champya_header.dart';
// import '../../../Core/Widgets/filter.dart';
// import '../../../Core/Widgets/input_box.dart';
// import '../../../Core/Widgets/loading.dart';
// import '../../../Core/Widgets/simple_header.dart';
// import '../../../Core/Widgets/submit_button.dart';
// import '../Controllers/add.dart';
// import '../Widgets/add-video-header.dart';

// class AddVideoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<AddVideoProvider>(
//       create: (ctx) => AddVideoProvider(),
//       child: AddVideoScreenTile(),
//     );
//   }
// }

// class AddVideoScreenTile extends StatefulWidget {
//   const AddVideoScreenTile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _AddVideoScreenTileState createState() => _AddVideoScreenTileState();
// }

// class _AddVideoScreenTileState extends State<AddVideoScreenTile> {
//   @override
//   initState() {
//     super.initState();
//     // Future.microtask(
//     //   () => Provider.of<Test>(context, listen: false).getUserDatas(context),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeData = Theme.of(context).textTheme;
//     return Consumer<AddVideoProvider>(
//       builder: (ctx, provider, _) => Scaffold(
//         body: FilterWidget(
//           child: provider.isLoading
//               ? Center(
//                   child: LoadingWidget(),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: ListView(
//                     children: [
//                       ChampyaHeader(),
//                       SizedBox(height: 15),
//                       GlobalBackButton(title: 'Videoes'),
//                       SimpleHeader(
//                         mainHeader: 'Add a video',
//                         subHeader: 'thank you for sharing',
//                       ),
//                       SizedBox(height: 15),
//                       AddVideoHeader(
//                         provider: provider,
//                         themeData: themeData,
//                       ),
//                       InputBox(
//                         label: 'VIDEO TITLE',
//                         controller: provider.titleCtrl,
//                       ),
//                       SizedBox(height: 20),
//                       InputBox(
//                         label: 'VIDEO DESCRIPTION',
//                         controller: provider.descCtrl,
//                         minLines: 3,
//                         maxLines: 6,
//                       ),
//                       SizedBox(height: 20),
//                       SubmitButton(
//                         func: () {},
//                         icon: null,
//                         title: 'UPLOAD THE VIDEO',
//                       ),
//                       SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
