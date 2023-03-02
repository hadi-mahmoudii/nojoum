import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../../../Core/Widgets/submit_button2.dart';
import '../Controllers/forget.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  @override
  void dispose() {
    Get.delete<ForgetPassController>();
    super.dispose();
  }

  final ForgetPassController provider = Get.put(ForgetPassController());

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
                              FlutterIcons.chat_1,
                              size: 80,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '''WE'RE
HERE
TO HELP''',
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
                        mainHeader: 'forget password',
                        subHeader: 'please provide us your email',
                        showRightAngle: false,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: provider.codeSended.value
                            ? provider.verifyComplated.value
                                ? ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: LayoutBuilder(
                                          builder: (ctx, cons) => Row(
                                            children: [
                                              Expanded(
                                                child: SubmitButton(
                                                  func: () => provider
                                                      .changePassword(context),
                                                  icon: null,
                                                  title: 'CHANGE PASSWORD',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                    ],
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Row(
                                        children: [
                                          const Spacer(),
                                          SizedBox(
                                            width: 150,
                                            child: InputBox(
                                              // icon: null,
                                              label: 'Code',
                                              controller: provider.codeCtrl,
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return 'Required';
                                                }
                                                return null;
                                              },
                                              maxLength: 9,
                                              textType: TextInputType.number,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: LayoutBuilder(
                                          builder: (ctx, cons) => Row(
                                            children: [
                                              Expanded(
                                                child: SubmitButton(
                                                  func: () =>
                                                      provider.forgetPassVerify(
                                                          context),
                                                  icon: null,
                                                  title: 'VERIFY THE CODE',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                    ],
                                  )
                            : ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  InputBox(
                                    // icon: null,
                                    label: 'Your Email',
                                    controller: provider.emailCtrl,
                                    validator: (String value) {
                                      if (value.isEmpty) return 'Required';
                                      if (!GetUtils.isEmail(value)) {
                                        return 'Invalid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  SubmitButton(
                                    func: () =>
                                        provider.forgetPassRequest(context),
                                    icon: null,
                                    title: 'SEND THE CODE',
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
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
