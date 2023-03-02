import 'package:flutter/material.dart';

class InfoContactNavigators extends StatelessWidget {
  const InfoContactNavigators({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final TextTheme themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(.7),
          ),
          bottom: BorderSide(
            color: Colors.white.withOpacity(.7),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            child: Text(
              'ABOUT US',
              style: themeData.caption,
            ),
          ),
          InkWell(
            child: Text(
              'CONTACT US',
              style: themeData.caption,
            ),
          )
        ],
      ),
    );
  }
}
