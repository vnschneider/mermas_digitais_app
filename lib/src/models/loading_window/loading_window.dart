import 'package:flutter/material.dart';

class LoadingWindow extends StatelessWidget {
  const LoadingWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        color: Color.fromARGB(255, 221, 199, 248),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 5),
              Text(
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
