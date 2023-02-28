import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  PasswordField(
      {super.key, required this.controller, required this.showPassword});

  final TextEditingController controller;
  bool showPassword;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 51, 0, 67),
          border: Border.all(color: const Color.fromARGB(255, 221, 199, 248)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.showPassword,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.showPassword = false;
                  });
                  print(widget.showPassword);
                },
                child: const Icon(
                  Icons.remove_red_eye_sharp,
                  color: Color.fromARGB(200, 221, 199, 248),
                ),
              ),
              border: InputBorder.none,
              hintText: 'Senha',
              hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 221, 199, 248)),
            ),
          ),
        ),
      ),
    );
  }
}
