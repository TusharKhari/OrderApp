import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  const AppTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        controller: controller,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
