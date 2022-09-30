import 'package:flutter/material.dart';

import '../utils/validation.dart';
import 'custom_text_field.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    this.controller,
    this.title = 'Email Address',
    this.hintText = 'myemail@gmail.com',
    this.onSaved,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  final String hintText;
  final Function(String)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
        ),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          validateFunction: Validations.validateEmail,
          textInputType: TextInputType.emailAddress,
          onSaved: onSaved,
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }
}
