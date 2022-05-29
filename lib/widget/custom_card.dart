import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;

  const CustomCard({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1, color: Colors.grey.shade200),
        ),
        child: child,
      ),
    );
  }
}
