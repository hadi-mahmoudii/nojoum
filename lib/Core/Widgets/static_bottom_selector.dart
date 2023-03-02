import 'package:flutter/material.dart';
import 'flutter_icons.dart';

import '../Models/option_model.dart';
import 'empty.dart';
import 'input_box.dart';

class StaticBottomSelector extends StatefulWidget {
  // final IconData? icon;
  final String? label;
  final Function? function;
  final Future<dynamic>? futureFunction;
  final TextEditingController? controller;
  final Function? validator;
  final bool enable;
  final List<OptionModel>? datas;
  final bool mustFill;
  final IconData? endIcon;
  final AlignmentGeometry itemsAlignment;

  const StaticBottomSelector({
    Key? key,
    // @required this.icon,
    required this.label,
    required this.controller,
    required this.datas,
    this.validator,
    this.function,
    this.futureFunction,
    this.enable = true,
    this.mustFill = false,
    this.endIcon = FlutterIcons.angle_down,
    this.itemsAlignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  _StaticBottomSelectorState createState() => _StaticBottomSelectorState();
}

class _StaticBottomSelectorState extends State<StaticBottomSelector> {
  bool isTapped = false;
  List<OptionModel> datas = [];
  @override
  void initState() {
    if (widget.datas != null) datas = widget.datas!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputBox(
      // color: widget.color,
      // icon: widget.icon,
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      mustFill: widget.mustFill,
      validator: widget.validator,
      endIcon: widget.endIcon,
      onTapFunction: () async {
        await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (mainCtx) => Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white10,
            // constraints: BoxConstraints(maxHeight: AppSession.deviceHeigth / 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(' '),
                    ),
                  ),
                  datas.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, ind) => InkWell(
                            onTap: () async {
                              widget.controller!.text = datas[ind].title!;
                              Navigator.of(mainCtx).pop();
                              if (widget.function != null) widget.function!();
                              if (widget.futureFunction != null) {
                                await widget.futureFunction;
                              }
                            },
                            child: Container(
                              alignment: widget.itemsAlignment,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                datas[ind].title!,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontSize: 4 * AppSession.deviceBlockSize,
                                ),
                              ),
                            ),
                          ),
                          itemCount: datas.length,
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: EmptyWidget(),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
