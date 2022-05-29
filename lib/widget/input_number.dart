import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;

  const NumberInput({
    Key? key,
    this.label,
    this.controller,
    this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label!,
        hintText: hintText!,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        value = controller!.text;
        if (value.isEmpty) {
          return 'Inserer une adresse E-mail';
        }
        return null;
      },
    );
  }
}
