import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.enabled,
      required this.useController,
      this.controller,
      this.keyboardType,
      this.expanded,
      this.hintText,
      this.useSufixIcon,
      this.icon});

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? useSufixIcon;
  final Icon? icon;
  final bool? enabled;
  final bool? useController;
  final bool? expanded;
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: TextFormField(
                  showCursor: true,
                  cursorHeight: 15,
                  cursorWidth: 1,
                  maxLines: expanded == false ? 1 : null,
                  keyboardType: keyboardType,
                  enabled: enabled,
                  decoration: InputDecoration(
                    suffixIcon: useSufixIcon == true ? icon : null,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                        //fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 221, 199, 248)),
                  ),
                  controller: useController == true ? controller : null,
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
