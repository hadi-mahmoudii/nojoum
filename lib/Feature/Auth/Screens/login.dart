import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/submit_button2.dart';

import '../../../Core/Config/routes.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Controllers/login.dart';
import '../Widgets/forget_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    super.initState();
  }

  final LoginController provider = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(
                  child: LoadingWidget(),
                )
              : Form(
                  key: provider.formKey,
                  child: ListView(
                    controller: provider.scrollController,
                    children: [
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FlutterIcons.login,
                              size: 100,
                              color: Colors.white,
                            ),
                            Text(
                              '''TAKE
YOU
IN''',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                // fontWeight: FontWeight.bold,
                                height: .9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // GlobalBackButton(
                      //   title: 'HOME',
                      // ),
                      const SimpleHeader(
                        mainHeader: 'Login',
                        subHeader: 'PLEASE PROVIDE US YOUR LOGIN INFO',
                        showRightAngle: false,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InputBox(
                          label: 'Your Email ADDRESS',
                          controller: provider.emailCtrl,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            if (!GetUtils.isEmail(value)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InputBox(
                          label: 'password',
                          controller: provider.passwordCtrl,
                          hideContent: true,
                          minLines: 1,
                          maxLines: 1,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            if (value.length < 8) return 'Atleast 8 characters';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SubmitButton(
                          func: () => provider.login(context),
                          icon: null,
                          title: 'LOG IN',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SubmitButton2(
                          func: () => Get.toNamed(Routes.register),
                          icon: null,
                          title: 'REGISTRATION',
                        ),
                      ),
                      const SizedBox(height: 15),
                      const ForgetNavigatorButton(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
