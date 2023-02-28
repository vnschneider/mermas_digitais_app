import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OlaMerma extends StatelessWidget {
  const OlaMerma({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/logo_branca.svg',
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 20),

        //Ola merma
        const Text(
          'Bem vinda, mermã!',
          style: TextStyle(
              color: Color.fromARGB(255, 221, 199, 248),
              fontFamily: 'PaytoneOne',
              //fontWeight: FontWeight.bold,
              fontSize: 30),
        ),

        //Bemvinda
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
              color: Color.fromARGB(255, 221, 199, 248),
              fontFamily: 'Poppins',
              //fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
