// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/global_appbar.dart';

import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/submit_button.dart';
import '../Controllers/change_pass.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  @override
  void dispose() {
    Get.delete<ChangePassController>();
    super.dispose();
  }

  final ChangePassController provider = Get.put(ChangePassController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        appBar: GlobalAppbar(
          subtitle: '',
          title: 'CHANGE PASSWORD',
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(child: LoadingWidget())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: provider.formKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        InputBox(
                          // icon: null,
                          label: 'YOUR OLD PASSWORD',
                          controller: provider.curPass,
                          hideContent: true,
                          maxLines: 1,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            if (value.length < 8) return 'Atleast 8 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputBox(
                          // icon: null,
                          label: 'NEW PASSWORD',
                          controller: provider.newPass,
                          hideContent: true,
                          maxLines: 1,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            if (value.length < 8) return 'Atleast 8 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputBox(
                          // icon: null,
                          label: 'NEW PASSWORD AGAIN',
                          controller: provider.reNewPass,
                          hideContent: true,
                          maxLines: 1,
                          validator: (String value) {
                            if (value.isEmpty) return 'Required';
                            if (value.length < 8) return 'Atleast 8 characters';
                            if (provider.newPass.text !=
                                provider.reNewPass.text)
                              return 'Passwords most be samed';
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        SubmitButton(
                          func: () => provider.changePassword(context),
                          icon: null,
                          title: 'UPDATE PASSWORD',
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
