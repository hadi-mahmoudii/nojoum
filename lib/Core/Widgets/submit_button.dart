import 'package:flutter/material.dart';
import 'package:nojoum/Core/Widgets/loading.dart';

import '../Config/app_session.dart';

class SubmitButton extends StatefulWidget {
  final Function? func;
  final Color? color;
  final IconData? icon;
  final String? title;
  final double? fontSize;

  const SubmitButton({
    Key? key,
    @required this.func,
    @required this.icon,
    @required this.title,
    this.color = mainFontColor,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!isloading) {
          setState(() {
            isloading = true;
          });
          await widget.func!();
          try {
            setState(() {
              isloading = false;
            });
          } catch (_) {}
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: widget.color!.withOpacity(.66), width: 2),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     blurRadius: 30,
          //     color: color!.withOpacity(.3),
          //     offset: Offset(0, 15),
          //     // spreadRadius: 5,
          //   ),
          // ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isloading
              ? [const LoadingWidget()]
              : [
                  widget.icon != null
                      ? Icon(
                          widget.icon,
                          color: widget.color!.withOpacity(.66),
                          size: 13,
                        )
                      : Container(),
                  // SizedBox(width: 5),
                  widget.title != ''
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            widget.title!.toUpperCase(),
                            textAlign: TextAlign.end,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: widget.color!.withOpacity(.66),
                                      fontSize: widget.fontSize,
                                      letterSpacing: 2.5,
                                    ),
                          ),
                        )
                      : Container(),
                ],
        ),
      ),
    );
  }
}
