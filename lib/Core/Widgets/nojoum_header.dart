import 'package:flutter/material.dart';

class NojoumHeader extends StatelessWidget {
  const NojoumHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 30,
            textColor: Colors.white,
          ),
          Text(
            'NOJOUM',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}
