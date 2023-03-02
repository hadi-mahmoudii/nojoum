import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Config/app_session.dart';
import 'package:nojoum/Core/Config/routes.dart';
import 'package:nojoum/Core/Widgets/filter.dart';
import 'package:nojoum/Core/Widgets/loading.dart';

import 'Config/urls.dart';
import 'Models/server_request.dart';
import 'Widgets/error_result.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  @override
  void didChangeDependencies() async {
    if (isLoading) {
      final Either<ErrorResult, dynamic> result =
          await ServerRequest().fetchData(
        Urls.getHeaderImage,
      );
      result.fold(
        (error) async {},
        (result) {
          log(result.toString());
          try {
            Get.find<AppSession>().setHeaderImage(result['data']['url']);
          } catch (_) {}
        },
      );
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamed(Routes.mainScreen);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilterWidget(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/Icons/logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                'Nojoum'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'Music App'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 25,
                  letterSpacing: 6.5,
                ),
              ),
              const Spacer(),
              const LoadingWidget(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
