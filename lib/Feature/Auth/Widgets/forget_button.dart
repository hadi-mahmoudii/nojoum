import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Config/routes.dart';

class ForgetNavigatorButton extends StatelessWidget {
  const ForgetNavigatorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.forgetPass),
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
              'Forget your password?',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                  ),
            ),
            const SizedBox(width: 20),
            Text(
              'RECOVER IT',
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
