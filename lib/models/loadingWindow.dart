// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LoadingWindow extends StatelessWidget {
  const LoadingWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 221, 199, 248),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 5),
              const Text(
                "Carregando",
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 0, 67),
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
