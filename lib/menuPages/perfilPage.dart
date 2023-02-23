// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/models/loadingWindow.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
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
              'Perfil',
              style: TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: 'PaytoneOne',
                  //fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Card(
              //margin: const EdgeInsets.only(bottom: 520),
              color: const Color.fromARGB(255, 221, 199, 248),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.personalcard,
                      size: 90,
                      color: Color.fromARGB(255, 51, 0, 67),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser != null
                              ? 'Lorem Ipsum da Silva'
                              : 'Lorem Ipsum da Silva',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 0, 67),
                            fontFamily: "PaytoneOne",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email!,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 51, 0, 67),
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWindow();
                                });
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.of(context).pop();
                              FirebaseAuth.instance.signOut();
                            });

                            // ignore: use_build_context_synchronously
                          },
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Iconsax.logout,
                                size: 25,
                                color: Color.fromARGB(255, 51, 0, 67),
                                fill: 1,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Sair',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
