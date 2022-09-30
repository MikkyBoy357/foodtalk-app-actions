import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({Key? key, this.text = "Invalid request"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String text;

  const SuccessDialog({Key? key, this.text = "Request was successful"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text(text),
      actions: [
        ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
