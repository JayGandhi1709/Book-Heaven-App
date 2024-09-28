import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text, // Default to text input
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText ?? "Enter $labelText",
          border: const OutlineInputBorder(),
        ),
        // validator: validator,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return "Please enter $labelText";
              }
              return null;
            },
      ),
    );
  }
}
