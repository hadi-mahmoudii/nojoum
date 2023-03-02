// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// import '../resources/app_colors.dart';
// import 'base_controller.dart';

// abstract class BaseView<Controller extends BaseController>
//     extends GetView<Controller> {
//   BaseView({final Key? key}) : super(key: key);

//   final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();


//   PreferredSizeWidget? appBar(final BuildContext context) {
//     return null;
//   }

//   // You can Override it
//   bool safeArea() {
//     return true;
//   }

//   // You can Override it
//   bool resizeToAvoidBottomInset() {
//     return false;
//   }

//   Future<bool> onWillPop(final BuildContext context) async {
//     Navigator.of(context).pop();
//     return false;
//   }

//   Widget body(final BuildContext context);

//   @override
//   Widget build(final BuildContext context) {
//     // debugPrint('PageStateBase++> '+controller.pageState.toString());
//     return GestureDetector(
//       onTap: () {
//        // FocusScope.of(context).requestFocus(FocusNode());
//         FocusScope.of(context).requestFocus(FocusNode());
//       },
//       child: Stack(
//         children: [
//           Obx(
//             () => controller.pageState.when(
//               idle: () {
//                 return  annotatedRegion(context);
//               },
//               loading: _showLoading,
//               data: (final data) {
//                 return Container();
//               },
//               lostConnection: () { return Container(); },
//             ),
//           ),

//         ],
//       ),
//     );
//   }

//   Widget annotatedRegion(final BuildContext context) {
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(
//         //Status bar color for android
//         statusBarColor: statusBarColor(),
//         statusBarIconBrightness: Brightness.light,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: pageContent(context),
//       ),
//     );
//   }

//   Widget pageScaffold(final BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => onWillPop(context),
//       child: Scaffold(
//         //sets ios status bar color
//         backgroundColor: pageBackgroundColor(),
//         key: globalKey,
//         appBar: appBar(context),
//         floatingActionButton: floatingActionButton(),
//         floatingActionButtonLocation: floatingActionButtonLocation(),
//         body: body(context),
//         bottomNavigationBar: bottomNavigationBar(),
//         drawer: drawer(),
//         resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
//       ),
//     );
//   }

//   Widget pageContent(final BuildContext context) {
//     return safeArea()
//         ? SafeArea(
//             child: pageScaffold(context),
//           )
//         : pageScaffold(context);
//   }

//   Widget showErrorSnackBar(final String message) {
//     final snackBar = SnackBar(content: Text(message));
//     WidgetsBinding.instance?.addPostFrameCallback((final timeStamp) {
//       ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
//     });

//     return Container(color: AppColors.background,);
//   }

//   Color pageBackgroundColor() {
//     return AppColors.background;
//   }

//   Color statusBarColor() {
//     return Colors.transparent;
//   }

//   Widget? floatingActionButton() {
//     return null;
//   }

//   Widget? bottomNavigationBar() {
//     return null;
//   }

//   Widget? drawer() {
//     return null;
//   }

//   Widget _showLoading() {
//     return Center(child: Container(color: Colors.transparent,child: const LoadingWidget(color: AppColors.primary,)));
//   }

//   FloatingActionButtonLocation? floatingActionButtonLocation() {
//     return FloatingActionButtonLocation.endFloat;
//   }
// }
