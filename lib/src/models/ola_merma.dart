import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OlaMerma extends StatelessWidget {
  const OlaMerma({
    super.key,
    required this.usetext,
    required this.text,
    required this.title,
  });

  final bool usetext;
  final String text;
  final String title;

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

        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(
                color: Color.fromARGB(255, 221, 199, 248),
                fontFamily: 'PaytoneOne',
                //fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),

        //Bemvinda

        const SizedBox(height: 5),
        usetext == true
            ? Text(
                textAlign: TextAlign.center,
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 221, 199, 248),
                    fontFamily: 'Poppins',
                    //fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            : const SizedBox(height: 20),
      ],
    );
  }
}
