import 'dart:io';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:nojoum/Core/splash_screen.dart';

import 'Core/Config/app_session.dart';
import 'Core/Config/routes.dart';
import 'Core/binding/main.dart';

void main() async {
  if (Platform.isAndroid || Platform.isIOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
    await GetStorage.init();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
      statusBarIconBrightness:
          Platform.isIOS ? Brightness.dark : Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      // AwesomeNotifications().initialize(
      //     // set the icon to null if you want to use the default app icon
      //     'resource://drawable/icon',
      //     [
      //       NotificationChannel(
      //           channelGroupKey: 'media_player_tests',
      //           icon: 'resource://drawable/res_media_icon',
      //           channelKey: 'media_player',
      //           channelName: 'Media player controller',
      //           channelDescription: 'Media player controller',
      //           defaultPrivacy: NotificationPrivacy.Public,
      //           enableVibration: false,
      //           enableLights: false,
      //           playSound: false,
      //           locked: true),
      //     ],
      //     channelGroups: [
      //       NotificationChannelGroup(
      //           channelGroupkey: 'media_player_tests',
      //           channelGroupName: 'Media Player tests')
      //     ]);
      runApp(const MyApp());
    });
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nojoum',
      initialBinding: MainBinding(),
      theme: ThemeData(
        primaryColor: mainFontColor,
        fontFamily: 'montserrat',
        colorScheme: const ColorScheme.light(secondary: Color(0XFFFFD600)),
        canvasColor: Colors.black,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          // selectionColor: Colors.white,
          selectionHandleColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          headline2: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontFamily: 'montserratlight',
          ),
          headline3: const TextStyle(
            fontSize: 12,
            color: Color(0XFFB9B9B9),
            fontFamily: 'montserratlight',
          ),
          headline4: const TextStyle(fontSize: 18, color: Colors.white),
          headline5: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'montserrat',
          ),
          headline6: const TextStyle(
            fontSize: 12,
            color: Color(0XFFADADAD),
            fontFamily: 'montserrat',
          ),
          subtitle1: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontFamily: 'montserratlight',
          ),
          subtitle2: const TextStyle(
            fontSize: 8,
            color: Color(0XFFBEBEBE),
            fontFamily: 'montserratlight',
          ),
          caption: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontFamily: 'montserrat',
          ),
          overline: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(.5),
            fontFamily: 'montserratmedium',
            letterSpacing: 4.75,
          ),
          button: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontFamily: 'montserrat',
          ),
          bodyText1: const TextStyle(
            fontSize: 10,
            color: Color(0XFFE3E3E3),
            fontFamily: 'montserratlight',
          ),
        ),
      ),
      getPages: Routes.routes,
      home: const SplashScreen(),
    );
  }
}
