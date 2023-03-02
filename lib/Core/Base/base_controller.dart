// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:tempapp/Core/base/result_state.dart';

// import '../local_storage/user_storage_service.dart';

// abstract class BaseController extends GetxController {
//   // late StreamSubscription<InternetConnectionStatus> _connectionListener;

//   final _pageStateController = const ResultState.idle().obs;

//   ResultState get pageState => _pageStateController.value;

//   ResultState updatePageState(final ResultState state) =>
//       _pageStateController(state);

//   ResultState showLoading() => updatePageState(const ResultState.loading());

//   ResultState resetPageState() => updatePageState(const ResultState.idle());

//   ResultState hideLoading() => resetPageState();

//   void logout() {
//     if (!kDebugMode) {
//       UserStoreService.to.removeToken();
//       // Get.toNamed(Routes.splash);
//     }
//   }
// }
