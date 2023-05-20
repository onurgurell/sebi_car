import 'package:flutter/material.dart';

void customSnackBar(String message, BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
