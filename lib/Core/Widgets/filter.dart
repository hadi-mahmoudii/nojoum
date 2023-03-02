// import 'dart:ui';

import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final Widget? child;
  final String? imagePath;
  const FilterWidget({
    Key? key,
    @required this.child,
    this.imagePath = 'assets/Images/image.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    return Container(
      height: mediaData.size.height,
      width: mediaData.size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/Images/background.jpg",
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
    // Stack(
    //   children: <Widget>[
    //     new ConstrainedBox(
    //       constraints: const BoxConstraints.expand(),
    //       child: new Image.asset(
    //         imagePath!,
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width,
    //         fit: BoxFit.fitHeight,
    //       ),
    //     ),
    //     new BackdropFilter(
    //       filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
    //       child: new Container(
    //         height: mediaData.size.height,
    //         width: mediaData.size.width,
    //         decoration: new BoxDecoration(color: Colors.black.withOpacity(.7)),
    //         child: child,
    //       ),
    //     ),
    //   ],
    // );
  }
}
