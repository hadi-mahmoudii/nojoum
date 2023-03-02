import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../Controllers/register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    Get.delete<RegisterController>();
    super.dispose();
  }

  final RegisterController provider = Get.put(RegisterController());
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
                              FlutterIcons.plus_linear,
                              size: 80,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '''JOIN
THE
CLUB''',
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
                      const SimpleHeader(
                        mainHeader: 'REGISTRATION',
                        subHeader: 'please provide us THIS INFORMATION',
                        showRightAngle: false,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            InputBox(
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
                            const SizedBox(height: 20),
                            InputBox(
                              label: 'your first name',
                              controller: provider.fNameCtrl,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            InputBox(
                              label: 'your last name',
                              controller: provider.lNameCtrl,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            InputBox(
                              label: 'password',
                              controller: provider.passwordCtrl,
                              hideContent: true,
                              maxLines: 1,
                              minLines: 1,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                if (value.length < 8) {
                                  return 'Atleast 8 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            InputBox(
                              label: 'your password again',
                              controller: provider.rePasswordCtrl,
                              hideContent: true,
                              maxLines: 1,
                              minLines: 1,
                              validator: (String value) {
                                if (value.isEmpty) return 'Required';
                                if (value.length < 8) {
                                  return 'Atleast 8 characters';
                                }

                                if (provider.passwordCtrl.text !=
                                    provider.rePasswordCtrl.text) {
                                  return 'Passwords most be samed';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 40),
                            SubmitButton(
                              func: () => provider.register(context),
                              icon: null,
                              title: 'SIGN UP',
                            ),
                            const SizedBox(height: 15),
                            SubmitButton2(
                              func: () => Get.back(),
                              icon: null,
                              title: 'BACK TO LOGIN',
                            ),
                          ],
                        ),
                      ),

                      // ForgetNavigatorButton(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
