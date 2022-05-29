import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;

  const CustomButton({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 1.0, color: Colors.black),
      ),
      child: Text(title!),
    );
  }
}
