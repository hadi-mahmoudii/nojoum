import 'package:flutter/material.dart';

import '../Config/app_session.dart';

class InputBox extends StatefulWidget {
  // final Color? color;
  // final IconData? icon;
  final String? label;
  final Function? function;
  final Function? onTapFunction;
  final Function? changeFunction;
  final TextEditingController? controller;
  final bool enable;
  final TextInputType textType;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final bool mustFill;
  final Function? validator;
  final int? maxLength;
  final double fontSize;
  final TextDirection textDirection;
  final bool hideContent;
  final IconData? endIcon;

  const InputBox({
    Key? key,
    // @required this.color,
    // @required this.icon,
    @required this.label,
    @required this.controller,
    this.function,
    this.onTapFunction,
    this.changeFunction,
    this.enable = true,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.hideContent = false,
    this.minLines = 1,
    this.maxLines = 5,
    this.mustFill = false,
    this.fontSize = 12,
    this.textDirection = TextDirection.ltr,
    this.validator,
    this.maxLength,
    this.endIcon,
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool isTapped = false;
  Function? validator;
  @override
  void initState() {
    //this use for set default validator
    if (widget.validator != null) {
      validator = widget.validator;
    } else {
      validator = (value) {
        return null;
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: Directionality(
        textDirection: widget.textDirection,
        child: FocusScope(
          onFocusChange: (val) {
            setState(() {
              isTapped = val;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.hideContent,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            onTap: widget.onTapFunction != null
                ? () async {
                    widget.onTapFunction!();
                  }
                : () {},
            onChanged: widget.changeFunction != null
                ? (val) async {
                    // print(val);
                    widget.changeFunction!(val);
                  }
                : (val) {},
            validator: (val) => validator!(val),
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              // border: InputBorder.none,
              contentPadding: const EdgeInsets.only(bottom: 5),
              labelText: widget.label!.toUpperCase(),
              labelStyle: TextStyle(
                fontSize: widget.fontSize * 4 / 5,
                color: isTapped ? mainFontColor : mainFontColor.withOpacity(.5),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                // borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                // borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                // borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
                // borderRadius: BorderRadius.circular(15),
              ),
              // suffixIcon: widget.endIcon != null
              //     ? Icon(
              //         widget.endIcon,
              //         color: isTapped
              //             ? mainFontColor
              //             : mainFontColor.withOpacity(.5),

              //         // size: 5 * AppSession.deviceBlockSize,
              //       )
              //     : const SizedBox(
              //         width: 0,
              //         height: 0,
              //       ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: widget.color!.withOpacity(.5),
              //   ),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              // errorBorder: InputBorder.none,
              // disabledBorder: InputBorder.none,
              // prefixIcon: InkWell(
              //   onTap:
              //       widget.function != null ? () => widget.function!() : () {},
              //   child: Icon(
              //     widget.icon,
              //     color:
              //         isTapped ? mainFontColor : mainFontColor.withOpacity(.5),

              //     // size: 5 * AppSession.deviceBlockSize,
              //   ),
              // ),
            ),
            // cursorColor: widget.color,
            style: TextStyle(
              fontSize: widget.fontSize,
              color: mainFontColor,
            ),
            keyboardType: widget.textType,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
          ),
        ),
      ),
    );
  }
}
