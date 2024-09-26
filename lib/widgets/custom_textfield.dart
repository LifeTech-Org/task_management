import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.type, this.maxLines = 1});
  final TextInputType? type;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0),
        ),
      ),
    );
  }
}
