import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text, Color bgColor) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: bgColor,
    ),
  );
}
