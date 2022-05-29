import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String? title;
  final double? size;

  const CustomTitle({
    Key? key,
    this.title,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size!,
        color: Colors.black
      ),
    );
  }
}
