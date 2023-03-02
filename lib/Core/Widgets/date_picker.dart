import 'package:flutter/material.dart';

import '../Config/app_session.dart';

// import 'package:shamsi_date/shamsi_date.dart' as sd;
// import 'package:solar_datepicker/solar_datepicker.dart';

class DatePicker extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Function? function;
  final Function? optionalFunction;
  final Function? validator;
  final TextEditingController controller;
  final TextEditingController dateLabelCtrl;

  final bool enable;
  final bool onlyDate;

  const DatePicker({
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
    required this.controller,
    required this.dateLabelCtrl,
    this.validator,
    this.function,
    this.optionalFunction,
    this.enable = true,
    this.onlyDate = false,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool isTapped = false;
  late Function validator;
  @override
  void initState() {
    //this use for set default validator
    if (widget.validator != null) {
      validator = widget.validator!;
    } else {
      validator = (value) {
        return null;
      };
    }
    super.initState();
  }

  // final TextEditingController dateLabelCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: FocusScope(
        onFocusChange: (val) {
          setState(() {
            isTapped = val;
          });
        },
        child: TextFormField(
          onTap: () async {
            var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2040),
            );
            if (date == null) {
              return;
            }
            widget.controller.text = '${date.year}-${date.month}-${date.day}';
            widget.dateLabelCtrl.text =
                '${date.year}-${date.month}-${date.day}';

            // Jalali picked = await showPersianDatePicker(
            //   context: context,
            //   initialDate: Jalali.now(),
            //   firstDate: Jalali.now(),
            //   lastDate: Jalali(1450, 9),
            // );
            // if (picked == null) return;
            // TimeOfDay timePicked = await showPersianTimePicker(
            //   context: context,
            //   initialTime: TimeOfDay.now(),
            // );
            // if (timePicked == null) return;
            // Jalali result = Jalali(
            //   picked.year,
            //   picked.month,
            //   picked.day,
            //   timePicked.hour,
            //   timePicked.minute,
            // );
            // Gregorian gregorainDate = result.toGregorian();
            // // var label = picked.formatFullDate();
            // // print(label);
            // // print(picked.toDateTime());
            // // String value = DateConvertor.dateToGregorian(picked);
            // widget.controller.text = DateTime(
            //   gregorainDate.year,
            //   gregorainDate.month,
            //   gregorainDate.day,
            //   timePicked.hour,
            //   timePicked.minute,
            // ).toString();
            // // print(widget.controller.text);
            // // if (widget.onlyDate)
            // //   widget.controller.text = widget.controller.text.split(' ')[0];
            // dateLabelCtrl.text = result.formatFullDate() +
            //     ' ، ${result.hour}:${result.minute} ';
            // try {
            //   widget.optionalFunction();
            // } catch (e) {}
          },
          controller: widget.dateLabelCtrl,
          enabled: widget.enable,
          readOnly: true,
          decoration: InputDecoration(
            counterText: '',
            // isDense: true,
            // border: InputBorder.none,
            labelText: widget.label.toUpperCase(),
            labelStyle: TextStyle(
              fontSize: 15,
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
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: widget.color!.withOpacity(.5),
            //   ),
            //   borderRadius: BorderRadius.circular(15),
            // ),
            // errorBorder: InputBorder.none,
            // disabledBorder: InputBorder.none,
            suffixIcon: InkWell(
              onTap: widget.function != null ? () => widget.function!() : () {},
              child: Icon(
                widget.icon,
                color: isTapped ? mainFontColor : mainFontColor.withOpacity(.5),

                // size: 5 * AppSession.deviceBlockSize,
              ),
            ),
          ),
          // cursorColor: widget.color,
          style: const TextStyle(
            fontSize: 18,
            color: mainFontColor,
          ),
          minLines: 1,
          maxLines: 5,
        ),
      ),
    );
  }
}
