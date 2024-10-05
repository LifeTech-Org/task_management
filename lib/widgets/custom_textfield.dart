import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.type,
      this.maxLines = 1,
      this.controller,
      this.obscureText = false});
  final TextInputType? type;
  final int maxLines;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0),
        ),
      ),
    );
  }
}
