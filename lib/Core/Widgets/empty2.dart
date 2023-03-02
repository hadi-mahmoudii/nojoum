import 'package:flutter/material.dart';

class EmptyBox2 extends StatelessWidget {
  const EmptyBox2({
    Key? key,
    required this.icon,
    this.title = 'no item',
    this.topHeight = 200,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final double topHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: topHeight,
            ),
            Center(
              child: Icon(
                icon,
                size: 117,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
