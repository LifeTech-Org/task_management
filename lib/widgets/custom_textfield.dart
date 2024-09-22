import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.type});
  final TextInputType? type;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0),
        ),
      ),
    );
  }
}
