import 'package:flutter/material.dart';

import '../../../Core/Widgets/flutter_icons.dart';

class CommentHeader extends StatelessWidget {
  final Function angleFuncion;
  const CommentHeader({
    Key? key,
    required this.angleFuncion,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (ctx, cons) => ConstrainedBox(
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
                    'COMMENTS',
                    style: themeData.textTheme.headline2,
                  ),
                  SizedBox(
                    width: cons.maxWidth * 55 / 100,
                    child: const Divider(),
                    height: 1,
                  )
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => angleFuncion(),
              child: const Icon(
                FlutterIcons.plus_linear,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
