import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;

  const IconBox({
    Key? key,
    this.icon,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(15.0),
      child: Icon(
        icon!,
        size: 30.0,
        color: color,
      ),
    );
  }
}
