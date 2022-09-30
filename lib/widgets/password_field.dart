import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import '../utils/validation.dart';
import 'custom_text_field.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.controller,
    this.hintText = '*******',
    this.title = 'Password',
    this.obscureText = true,
    this.onSaved,
    this.onChange,
    this.validateFunction = Validations.validateString,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final String title;
  final bool obscureText;
  final void Function(String)? onSaved, onChange;
  final FormFieldValidator<String>? validateFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1A1C4E),
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
        ),
        CustomTextField(
          hintText: hintText,
          prefixIcon: Icon(
            FeatherIcons.lock,
            size: 15.0,
          ),
          controller: controller,
          onSaved: onSaved,
          onChange: onChange,
          obscureText: obscureText,
          enabled: true,
          validateFunction: Validations.validatePassword,
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }
}
