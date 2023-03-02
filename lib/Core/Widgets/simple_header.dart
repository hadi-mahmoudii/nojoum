import 'package:flutter/material.dart';

class SimpleHeader extends StatelessWidget {
  final String mainHeader;
  final String subHeader;
  final bool showRightAngle;
  final bool letPadding;
  final Function? angleFuncion;
  final IconData? angleIcon;
  const SimpleHeader({
    Key? key,
    required this.mainHeader,
    this.subHeader = '',
    this.showRightAngle = false,
    this.letPadding = true,
    this.angleFuncion,
    this.angleIcon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, cons) => Padding(
        padding: letPadding
            ? const EdgeInsets.only(left: 20, right: 10)
            : const EdgeInsets.only(left: 0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cons.maxWidth),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                // width: cons.maxWidth * 55 / 100,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: .15,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainHeader.toUpperCase(),
                      style: themeData.textTheme.headline2,
                    ),
                    subHeader.isNotEmpty
                        ? Text(
                            subHeader.toUpperCase(),
                            style: themeData.textTheme.headline3,
                          )
                        : Container(),
                    SizedBox(
                      width: cons.maxWidth * 55 / 100,
                      child: const Divider(),
                      height: 1,
                    )
                  ],
                ),
              ),
              const Spacer(),
              showRightAngle
                  ? IconButton(
                      onPressed: () => angleFuncion!(),
                      icon: Icon(
                        angleIcon!,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
