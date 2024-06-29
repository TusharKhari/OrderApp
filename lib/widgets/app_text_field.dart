import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_app/utils/global_variables.dart';

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
        style: des,
        decoration: InputDecoration(
          filled: true,
          fillColor: boxColor,
          focusColor: primaryColor,
          hintText: hintText,
          hintStyle: des,
          // hoverColor: primaryColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        controller: controller,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
