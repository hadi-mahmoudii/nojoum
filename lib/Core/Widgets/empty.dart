import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String label;
  const EmptyWidget({
    Key? key,
    this.label = 'Nothing to show',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        textDirection: TextDirection.rtl,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
