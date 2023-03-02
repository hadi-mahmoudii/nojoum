import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/simple_header.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Controllers/submit_code.dart';

class SubmitCodeScreen extends StatefulWidget {
  const SubmitCodeScreen({Key? key}) : super(key: key);

  @override
  State<SubmitCodeScreen> createState() => _SubmitCodeScreenState();
}

class _SubmitCodeScreenState extends State<SubmitCodeScreen> {
  @override
  void dispose() {
    Get.delete<SubmitCodeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SubmitCodeController provider = Get.put(SubmitCodeController(
        ModalRoute.of(context)!.settings.arguments as String));
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: FilterWidget(
            child: provider.isLoading.value
                ? const Center(
                    child: LoadingWidget(),
                  )
                : Form(
                    key: provider.formKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                FlutterIcons.chat,
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
                        // const GlobalBackButton(title: 'BACK'),
                        const SimpleHeader(
                          mainHeader: 'code verification',
                          subHeader: 'ENTER THE CODE',
                          showRightAngle: false,
                        ),
                        const SizedBox(height: 20),
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
                                  if (value.isEmpty) return 'Required';
                                  return null;
                                },
                                maxLength: 9,
                                textType: TextInputType.text,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: LayoutBuilder(
                            builder: (ctx, cons) => Row(
                              children: [
                                Expanded(
                                  child: SubmitButton(
                                    func: () => provider.submitCode(context),
                                    icon: null,
                                    title: 'VERIFY THE CODE',
                                  ),
                                ),
                                // SizedBox(width: 5),
                                // SubmitButton(
                                //   func: () {},
                                //   icon: null,
                                //   title: 'Sign in',
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
