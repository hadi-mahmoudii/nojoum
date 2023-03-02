import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/routes.dart';
import '../../Music/Controllers/details.dart';

class RegisterNavigatorButton extends StatelessWidget {
  const RegisterNavigatorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<MusicDetailsController>().pause();
        Get.toNamed(Routes.register);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.circular(5),
          // border: Border.all(color: mainFontColor),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Did not create an account yet? ',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                  ),
            ),
            const SizedBox(width: 20),
            Text(
              'REGISTRATION',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
