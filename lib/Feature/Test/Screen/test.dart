// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../Core/Widgets/loading.dart';
// import '../Controllers/test.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // print();
//     return ChangeNotifierProvider<TestProvider>(
//       create: (ctx) => TestProvider(),
//       child: const TestTile(),
//     );
//   }
// }

// class TestTile extends StatefulWidget {
//   const TestTile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _TestTileState createState() => _TestTileState();
// }

// class _TestTileState extends State<TestTile> {
//   @override
//   void initState() {
//     Future.microtask(() =>
//         Provider.of<TestProvider>(context, listen: false).fetchDatas(context));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TestProvider>(
//       builder: (ctx, provider, _) => SafeArea(
//         child: Scaffold(
//           // appBar: PreferredSize(
//           //   preferredSize: Size(double.infinity, 50),
//           //   child: GlobalAppbar(),
//           // ),
//           body: provider.isLoading
//               ? const Center(
//                   child: LoadingWidget(),
//                 )
//               : NotificationListener(
//                   onNotification: (ScrollNotification notification) {
//                     if (notification is ScrollUpdateNotification) {
//                       if (provider.scrollCtrl.position.pixels >
//                               provider.scrollCtrl.position.maxScrollExtent -
//                                   30 &&
//                           !provider.isLoadingMore) {
//                         provider.fetchDatas(context);
//                       }
//                     }
//                     return true;
//                   },
//                   child: RefreshIndicator(
//                     onRefresh: () => provider.fetchDatas(
//                       context,
//                       resetPage: true,
//                     ),
//                     child: ListView(
//                       controller: provider.scrollCtrl,
//                       children: const [
//                         SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }
