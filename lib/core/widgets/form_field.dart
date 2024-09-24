// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final bool obscure;
  final String? hintText;
  final String? label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.obscure,
    this.label,
    this.hintText,
    required this.controller,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label!),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontSize: 10,
        ),
        contentPadding: const EdgeInsets.only(left: 20),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 5, 45, 1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Color.fromRGBO(0, 5, 45, 1),
            width: 1,
          ),
        ),
        enabled: true,
      ),
    );
  }
}