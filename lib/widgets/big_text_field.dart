import 'package:flutter/material.dart';

import '../utils/validation.dart';
import 'custom_text_field.dart';

class MediumTextField extends StatelessWidget {
  const MediumTextField({
    Key? key,
    required this.controller,
    this.title = 'Title',
    this.hintText = 'type here...',
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
        ),
        CustomTextField(
          hintText: hintText,
          minLines: 1,
          maxLines: 5,
          controller: controller,
          validateFunction: Validations.validateString,
          textInputType: TextInputType.text,
        ),
        Container(
          height: 20,
        ),
      ],
    );
  }
}
