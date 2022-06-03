import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormPhone extends StatelessWidget {
  final Function(String)? onChanged;
  final Function()? onCleanTap;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final String label;
  final bool? pass;

   CustomTextFormPhone({
    Key? key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.textInputType,
    this.pass,
    this.onCleanTap,
  }) : super(key: key);

  final maskFormatter = MaskTextInputFormatter(mask: '+# (###) ###-##-##');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: pass ?? false,
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Это поле обязательное';
        }
        return null;
      },
      decoration: InputDecoration(

        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            if (onCleanTap != null) {
              onCleanTap!();
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      inputFormatters: [maskFormatter],
    );
  }
}
