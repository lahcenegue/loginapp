import 'package:flutter/material.dart';

Widget customTextFormField({
  Function(String)? onChanged,
  required String? Function(String?)? validator,
  required TextInputType? keyboardType,
  Widget? suffixIcon,
  bool obscureText = false,
  required IconData? prefixIcon,
  required String? hintText,
}) {
  return TextFormField(
    onChanged: onChanged,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(8),
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.grey,
      ),
      suffixIcon: suffixIcon,
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      hintText: hintText,
    ),
  );
}
