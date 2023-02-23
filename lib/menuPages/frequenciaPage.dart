// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FrequenciaPage extends StatefulWidget {
  const FrequenciaPage({super.key});

  @override
  State<FrequenciaPage> createState() => _FrequenciaPageState();
}

class _FrequenciaPageState extends State<FrequenciaPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: const Text(
            'Frequência',
            style: TextStyle(
                color: Color.fromARGB(255, 221, 199, 248),
                fontFamily: 'PaytoneOne',
                //fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: SafeArea(
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          color: const Color.fromARGB(255, 221, 199, 248),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Situação',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 0, 67),
                        fontFamily: "PaytoneOne",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                const Icon(
                  Iconsax.personalcard,
                  size: 120,
                  color: Color.fromARGB(255, 51, 0, 67),
                ),
                Text(
                  user.displayName != null
                      ? user.displayName!
                      : 'Lorem Ipsum da Silva',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 51, 0, 67),
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                LinearPercentIndicator(
                  barRadius: const Radius.circular(8),
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  lineHeight: 30,
                  percent: 0.8,
                  progressColor: const Color.fromARGB(255, 51, 0, 67),
                  backgroundColor: const Color.fromARGB(255, 221, 199, 248),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Você Possui 80% de presença nas aulas.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 0, 67),
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Parabéns pelo seu empenho!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 0, 67),
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: Text('')),
                TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 51, 0, 67))),
                  onPressed: () {},
                  child: const Text(
                    '   Detalhes   ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 221, 199, 248),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
