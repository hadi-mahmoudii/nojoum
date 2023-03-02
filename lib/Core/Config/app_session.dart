// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

class AppSession extends GetxController {
  var _token = ''.obs;
  String get token => _token.value;
  setToken(String value) {
    _token.value = value;
  }

  var _image = ''.obs;
  String get image => _image.value;
  setImage(String value) {
    _image.value = value;
  }

  var _headerImage = ''.obs;
  String get headerImage => _headerImage.value;
  setHeaderImage(String value) {
    _headerImage.value = value;
  }

  var _userName = ''.obs;
  String get userName => _userName.value;
  setUserName(String value) {
    _userName.value = value;
  }

  var selectedPage = 0.obs;
  changePage(int page) => selectedPage.value = page;
  PageController pgCtrl = PageController();
  // static String _token = '';
  // static String get token {
  //   return AppSession._token;
  // }

  // static set token(String token) {
  //   AppSession._token = token;
  // }

  // static String _userId = '';
  // static String get userId {
  //   return _userId;
  // }

  // static set userId(String userId) {
  //   AppSession._userId = userId;
  // }

  // static String _userName = '';
  // static String get userName {
  //   return _userName;
  // }

  // static set userName(String userName) {
  //   AppSession._userName = userName;
  // }

  // static String _userPhone = '';
  // static String get userPhone {
  //   return _userPhone;
  // }

  // static set userPhone(String userPhone) {
  //   AppSession._userPhone = userPhone;
  // }

  // getCardLength(BuildContext context) async {
  //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
  //     Urls.getCartCount,
  //   );
  //   result.fold(
  //     (error) async {},
  //     (result) async {
  //       cardLength = result['number'];
  //       notifyListeners();
  //     },
  //   );
  // }
  // static final AudioPlayer _audioPlayer = AudioPlayer();
  // static AudioPlayer get audioPlayer {
  //   return _audioPlayer;
  // }

  Future<bool> tryAutoLogin(BuildContext context) async {
    
    final prefs = GetStorage();

    if (!prefs.hasData('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.read('userData')!) as Map<String, dynamic>;
    setToken(userData['token']);
    try {
      setImage(userData['image']);
    } catch (_) {
      final prefs = GetStorage();
      prefs.remove('userData');
      setToken('');
      Fluttertoast.showToast(msg: 'Please do login again!');
      return false;
    }

    // AppSession.userId = userData['userId'];
    try {
      setUserName(userData['username']);
    } catch (_) {}
    // AppSession.userPhone = userData['userPhone'];
    // notifyListeners();
    // await getCardLength(context);
    return true;
  }
}

// class AppSession extends ChangeNotifier {
//   bool isLoading = true;
//   bool livePlaying = false;
//   late BetterPlayerController controller;
//   // late FlickManager flickManager;
//   Future getLive() async {
//     isLoading = true;
//     notifyListeners();
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//       BetterPlayerDataSourceType.network,
//       Urls.homeLive,
//       liveStream: true,
//       // resolutions: urls,
//     );
//     controller = BetterPlayerController(
//       BetterPlayerConfiguration(
//         controlsConfiguration: const BetterPlayerControlsConfiguration(
//           enableProgressText: true,
//           liveTextColor: Colors.white,
//         ),
//         autoDetectFullscreenDeviceOrientation: true,
//         autoPlay: true,
//         errorBuilder: (ctx, _) => const Center(
//           child: Text('Error play live!'),
//         ),
//         allowedScreenSleep: false,
//         showPlaceholderUntilPlay: true,
//         // placeholder: Image.network(widget.imageLink!),
//         looping: true,
//         // fullScreenByDefault: true,
//       ),
//       betterPlayerDataSource: betterPlayerDataSource,
//     );
//     isLoading = false;
//     notifyListeners();
//     // controller = VideoPlayerController.network(Urls.homeLive)
//     //   ..initialize().then((value) async {
//     //     flickManager = FlickManager(
//     //       videoPlayerController: controller,
//     //       autoInitialize: false,
//     //       autoPlay: false,
//     //     );
//     //     await controller.play();
//     //     livePlaying = true;
//     //     isLoading = false;
//     //     notifyListeners();
//     //   });
//   }

//   changeLiveStatus(bool isPause) async {
//     livePlaying = !isPause;
//     if (isPause) {
//       try {
//         controller.dispose();
//       } catch (e) {}
//     } else {
//       try {
//         await getLive();
//       } catch (e) {}
//     }
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     try {
//       controller.dispose();
//     } catch (e) {}
//     super.dispose();
//   }

//   static String _token = '';
//   static String get token {
//     return AppSession._token;
//   }

//   static set token(String token) {
//     AppSession._token = token;
//   }

//   static String _userId = '';
//   static String get userId {
//     return _userId;
//   }

//   static set userId(String userId) {
//     AppSession._userId = userId;
//   }

//   static String _userName = '';
//   static String get userName {
//     return _userName;
//   }

//   static set userName(String userName) {
//     AppSession._userName = userName;
//   }

//   static String _userPhone = '';
//   static String get userPhone {
//     return _userPhone;
//   }

//   static set userPhone(String userPhone) {
//     AppSession._userPhone = userPhone;
//   }

//   int cardLength = 0;
//   changeCardLength(int value) {
//     cardLength = value;
//     notifyListeners();
//   }

//   // getCardLength(BuildContext context) async {
//   //   final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
//   //     Urls.getCartCount,
//   //   );
//   //   result.fold(
//   //     (error) async {},
//   //     (result) async {
//   //       cardLength = result['number'];
//   //       notifyListeners();
//   //     },
//   //   );
//   // }
//   static final AudioPlayer _audioPlayer = AudioPlayer();
//   static AudioPlayer get audioPlayer {
//     return _audioPlayer;
//   }

//   Future<bool> tryAutoLogin(BuildContext context) async {
//     // var sizes = MediaQuery.of(context).size;
//     // setSizes(sizes);
//     // AppSession.mainFontColor = Theme.of(context).primaryColor;
//     // AppSession.backgroundColor = Theme.of(context).canvasColor;
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final userData =
//         json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
//     AppSession.token = userData['token'];
//     // AppSession.userId = userData['userId'];
//     try {
//       AppSession.userName = userData['username'];
//     } catch (e) {}
//     // AppSession.userPhone = userData['userPhone'];
//     notifyListeners();
//     // await getCardLength(context);
//     return true;
//   }
// }

const Color mainFontColor = Colors.white;
