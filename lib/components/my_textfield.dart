import 'dart:ui';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;

  const MyTextField(
      {super.key,
      required this.obscureText,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.onTap,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        onTap: onTap,
        selectionHeightStyle: BoxHeightStyle.tight,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF1D4A86),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
        ),
      ),
    );
  }
}
