import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({
    required this.label, super.key,
    this.validator,
    this.onSaved,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.maxLines = 1,
  });
  final String label;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          // Optional: Adds a border
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
