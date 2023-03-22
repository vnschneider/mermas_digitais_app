import 'package:flutter/material.dart';

class DialogTextField extends StatelessWidget {
  const DialogTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.keyboardType,
      this.enabled,
      this.useController,
      this.expanded});

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? enabled;
  final bool? useController;
  final bool? expanded;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 51, 0, 67),
            border: Border.all(color: const Color.fromARGB(200, 221, 199, 248)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextFormField(
                showCursor: true,
                cursorHeight: 15,
                cursorWidth: 2,
                maxLines: expanded == false ? 1 : null,
                keyboardType: keyboardType,
                enabled: enabled,
                decoration: InputDecoration(
                  //suffixIcon: useSufixIcon == true ? icon : null,
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
      ]),
    );
  }
}
