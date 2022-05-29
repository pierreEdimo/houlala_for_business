import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final String? label;

  const NameInput({
    Key? key,
    this.controller,
    this.minLines,
    this.maxLines,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: label!,
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
