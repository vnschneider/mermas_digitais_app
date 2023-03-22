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
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "Poppins",
          //fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 221, 199, 248),
      duration: duration,
    ),
  );
}
