import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;

  const TextInput({
    Key? key,
    this.controller,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: "Nouveau Post",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        value = controller!.text;
        if (value.isEmpty) {
          return 'Inserer un Contenu';
        }
        return null;
      },
    );
  }
}
