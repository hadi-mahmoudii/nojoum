import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nojoum/Core/Widgets/flutter_icons.dart';

class DashboardRowNavigator extends StatelessWidget {
  const DashboardRowNavigator({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.icon,
  }) : super(key: key);

  final String title, subtitle, route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => Get.toNamed(route),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
              bottom: BorderSide(
                color: Colors.grey.withOpacity(.7),
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2.5,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFAFAFAF),
                      fontSize: 10,
                      fontFamily: 'montserratlight',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                FlutterIcons.right_chevron,
                size: 24,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
