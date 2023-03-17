import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.enabled,
      required this.useController,
      required this.controller,
      this.hintText});

  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final bool useController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 0, 67),
              border:
                  Border.all(color: const Color.fromARGB(200, 221, 199, 248)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      //fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 221, 199, 248)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
