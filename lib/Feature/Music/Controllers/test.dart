// import 'package:either_dart/either.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// import '../../../Core/Models/server_request.dart';
// import '../../../Core/Widgets/error_result.dart';

// class TestProvider extends ChangeNotifier with ReassembleHandler {
//   bool isLoading = true;
//   bool isLoadingMore = false;

//   TextEditingController textCtrl = TextEditingController();
//   ScrollController scrollCtrl = ScrollController();
//   int currentPage = 1;
//   bool lockPage = false;
//   List datas = [];

//   fetchDatas(BuildContext context,
//       {bool resetPage = false, bool resetFilter = false}) async {
//     if (resetPage) {
//       currentPage = 1;
//       lockPage = false;
//     }
//     if (lockPage) return;
//     if (currentPage == 1) {
//       // blogs = [];
//       isLoading = true;
//       notifyListeners();
//     } else {
//       isLoadingMore = true;
//       notifyListeners();
//     }
//     final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
//       'Urls.login',
//     );
//     result.fold(
//       (error) async {
//         // await ErrorResult.showDlg(error.type, context);
//         isLoading = false;
//         notifyListeners();
//       },
//       (result) {
//         // print(result);
//         // result['data'].forEach((element) {
//         //   blogs.add(BlogModel.fromJson(element));
//         // });
//         if (currentPage == 1) {
//           currentPage += 1;
//           isLoading = false;
//           notifyListeners();
//         } else {
//           if (result['data'].length > 0) {
//             currentPage += 1;
//           } else {
//             lockPage = true;
//           }
//           isLoadingMore = false;
//           notifyListeners();
//         }
//       },
//     );
//   }

//   fetchData(BuildContext context) async {
//     isLoading = true;
//     notifyListeners();

//     final Either<ErrorResult, dynamic> result3 =
//         await ServerRequest().fetchData(
//       'Urls.login',
//     );
//     result3.fold(
//       (error) async {
//         // await ErrorResult.showDlg(error.type, context);
//         isLoading = false;
//         notifyListeners();
//       },
//       (result) {
//         try {
//           // blog = BlogModel.fromJson(result['data']);
//           isLoading = false;
//           notifyListeners();
//         } catch (e) {
//           Fluttertoast.showToast(msg: 'خطا در دریافت اطلاعات!');
//           Get.back();
//         }
//       },
//     );
//   }

//   @override
//   void reassemble() {}
// }
