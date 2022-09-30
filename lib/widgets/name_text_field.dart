import 'package:flutter/material.dart';
import 'package:foodtalk/utils/validation.dart';

import 'custom_text_field.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? width;
  final String title;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onSaved, onChange;
  final FormFieldValidator<String>? validateFunction;
  final TextInputType? textInputType;

  const NameTextField({
    Key? key,
    this.controller,
    this.width,
    this.title = 'Title',
    this.hintText = 'Type here',
    this.obscureText = false,
    this.onSaved,
    this.onChange,
    this.validateFunction = Validations.validateString,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1A1C4E),
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
        ),
        CustomTextField(
          width: width,
          hintText: hintText,
          controller: controller,
          validateFunction: validateFunction,
          textInputType: textInputType,
          obscureText: obscureText,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
