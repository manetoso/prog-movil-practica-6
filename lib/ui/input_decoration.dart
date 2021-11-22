import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration customInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixedIcon
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple
        )
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      prefixIcon: prefixedIcon != null 
        ? Icon(prefixedIcon, color: Colors.deepPurple,)
        : null,
    );
  }
}