// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NewFrequenceWindow extends StatefulWidget {
  const NewFrequenceWindow({super.key});

  @override
  State<NewFrequenceWindow> createState() => _NewFrequenceWindowState();
}

class _NewFrequenceWindowState extends State<NewFrequenceWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Nova frequência",
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "PaytoneOne",
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'content',
            style: TextStyle(
              color: Color.fromARGB(255, 51, 0, 67),
              fontFamily: "Poppins",
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
