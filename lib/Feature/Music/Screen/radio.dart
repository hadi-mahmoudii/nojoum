import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../General/Model/radio.dart';
import '../Controllers/details.dart';
import '../Controllers/radio.dart';
import '../Widget/voice_play_box.dart';

class RadioDetailScreen extends StatelessWidget {
  const RadioDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print();
    return RadioDetailsTile(
      radio: ModalRoute.of(context)!.settings.arguments as RadioModel,
    );
  }
}

class RadioDetailsTile extends StatefulWidget {
  const RadioDetailsTile({
    Key? key,
    required this.radio,
  }) : super(key: key);
  final RadioModel radio;

  @override
  _RadioDetailsTileState createState() => _RadioDetailsTileState();
}

class _RadioDetailsTileState extends State<RadioDetailsTile> {
  final musicProvider = Get.find<MusicDetailsController>();
  late RadioDetailsController provider;
  @override
  void initState() {
    provider = Get.put(RadioDetailsController(widget.radio));
    Future.microtask(
        () => musicProvider.fetchData('', false, rad: widget.radio));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RadioDetailsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: GlobalAppbar(
          subtitle: 'Listen to the radio',
          title: provider.radio.name,
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: SingleChildScrollView(
            controller: provider.scrollCtrl,
            child: Column(
              children: [
                // ChampyaHeader(),
                // SizedBox(height: 15),
                // AspectRatio(
                //   aspectRatio: 2,
                //   child: FlickVideoPlayer(
                //     flickManager: provider.flickManager,
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.network(
                    provider.radio.image,
                    width: MediaQuery.of(context).size.width - 40,
                    height: MediaQuery.of(context).size.width - 40,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, _, __) => Image.asset(
                      'assets/Images/radioplaceholder.png',
                      width: MediaQuery.of(context).size.width - 40,
                      height: MediaQuery.of(context).size.width - 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 40,
                  ),
                  child: AudioUiBox(
                    // url: provider.music.link,
                    // provider: provider,
                    mainCtx: context,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../Core/Config/app_session.dart';
// import '../../../Core/Widgets/filter.dart';
// import '../../../Core/Widgets/global_appbar.dart';
// import '../../../Core/Widgets/loading.dart';
// import '../../General/Model/radio.dart';
// import '../Controllers/radio.dart';
// import '../Widget/radio_play_box.dart';

// class RadioDetailScreen extends StatefulWidget {
//   const RadioDetailScreen({Key? key}) : super(key: key);

//   @override
//   State<RadioDetailScreen> createState() => _RadioDetailScreenState();
// }

// class _RadioDetailScreenState extends State<RadioDetailScreen> {
//   @override
//   void dispose() {
//     Get.delete<RadioDetailsController>();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeData = Theme.of(context).textTheme;
//     final RadioDetailsController provider = Get.put(RadioDetailsController(
//         ModalRoute.of(context)!.settings.arguments as RadioModel));

//     return Obx(
//       () => SafeArea(
//         child: Scaffold(
//           appBar: GlobalAppbar(
//             subtitle: 'Listen to the radio',
//             title: provider.radio.name,
//             textTheme: themeData,
//           ).build(context),
//           body: FilterWidget(
//             child: provider.isLoading.value
//                 ? const Center(
//                     child: LoadingWidget(),
//                   )
//                 : SingleChildScrollView(
//                     controller: provider.scrollCtrl,
//                     child: Column(
//                       children: [
//                         // ChampyaHeader(),
//                         // SizedBox(height: 15),
//                         // AspectRatio(
//                         //   aspectRatio: 2,
//                         //   child: FlickVideoPlayer(
//                         //     flickManager: provider.flickManager,
//                         //   ),
//                         // ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Image.network(
//                             provider.radio.image,
//                             width: MediaQuery.of(context).size.width - 40,
//                             height: MediaQuery.of(context).size.width - 40,
//                             fit: BoxFit.cover,
//                             errorBuilder: (ctx, _, __) => Image.asset(
//                               'assets/Images/videoplaceholder.png',
//                               width: MediaQuery.of(context).size.width - 40,
//                               height: MediaQuery.of(context).size.width - 40,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 40,
//                           ),
//                           child: RadioUiBox(
//                             url: provider.radio.link,
//                             color: mainFontColor,
//                           ),
//                         ),
// //                         Container(
// //                           margin: const EdgeInsets.symmetric(horizontal: 60),
// //                           padding: const EdgeInsets.symmetric(vertical: 15),
// //                           decoration: const BoxDecoration(
// //                             border: Border(
// //                               top: BorderSide(color: Colors.white, width: .7),
// //                             ),
// //                           ),
// //                           child: Row(
// //                             children: const [

// // //                               const Text(
// // //                                 '3K',
// // //                                 style: TextStyle(
// // //                                   fontWeight: FontWeight.bold,
// // //                                   fontSize: 26,
// // //                                   color: Colors.white,
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(width: 10),
// // //                               Text(
// // //                                 '''times
// // // played''',
// // //                                 style:
// // //                                     themeData.headline3!.copyWith(height: .95),
// // //                               ),
// //                               Spacer(),
// //                               Icon(
// //                                 FlutterIcons.whatsapp,
// //                                 color: Colors.white,
// //                                 size: 22,
// //                               ),
// //                               SizedBox(width: 10),
// //                               Icon(
// //                                 FlutterIcons.heart_empty,
// //                                 color: Colors.white,
// //                                 size: 22,
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         const SizedBox(height: 20),
// //                         SingerNavigatorRow(themeData: themeData),
// //                         const SizedBox(height: 50),
// //                         const SimpleHeader(
// //                           mainHeader: 'NEXT songs',
// //                         ),
//                         // const SizedBox(height: 10),
//                         // ListView.separated(
//                         //   physics: NeverScrollableScrollPhysics(),
//                         //   shrinkWrap: true,
//                         //   itemBuilder: (ctx, ind) =>
//                         //       MusicRowNavigator(themeData: themeData),
//                         //   separatorBuilder: (ctx, ind) => const Padding(
//                         //     padding: EdgeInsets.symmetric(horizontal: 20),
//                         //     child: Divider(
//                         //       color: Colors.white,
//                         //       height: 20,
//                         //       thickness: .2,
//                         //     ),
//                         //   ),
//                         //   itemCount: 4,
//                         // ),
//                         const SizedBox(height: 50),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
