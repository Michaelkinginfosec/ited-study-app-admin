// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final Function(String?)? onChanged;
  final InputDecoration? decoration;
  final Widget? icon;
  const DropDownField({
    super.key,
    this.items,
    this.value,
    this.onChanged,
    this.decoration,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
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
        onChanged: onChanged,
        value: value,
        items: items,
        icon: icon,
      ),
    );
  }
}
