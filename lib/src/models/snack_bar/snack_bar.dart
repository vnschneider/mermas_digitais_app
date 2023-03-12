import 'package:flutter/material.dart';

void scaffoldMessenger({
  required BuildContext context,
  required Duration duration,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(228, 22, 22, 22),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.white,
      duration: duration,
    ),
  );
}
