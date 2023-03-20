import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.text});

  final String text;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      toolbarHeight: 65,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      title: Text(
        widget.text,
        style: const TextStyle(
            color: Color.fromARGB(255, 221, 199, 248),
            fontFamily: 'PaytoneOne',
            //fontWeight: FontWeight.bold,
            fontSize: 28),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 0, 67),
    );
  }
}
