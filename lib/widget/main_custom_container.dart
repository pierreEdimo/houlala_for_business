import 'package:flutter/material.dart';

class MainCustomContainer extends StatelessWidget {
  final Widget? child;

  const MainCustomContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: child!,
    );
  }
}
