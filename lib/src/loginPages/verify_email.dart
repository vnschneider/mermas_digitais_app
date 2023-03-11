import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/loginPages/new_user_page.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/ola_merma.dart';
import 'package:mermas_digitais_app/src/models/textFields/email_field.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  //Text Controller
  final _emailController = TextEditingController();

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: 'test123',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Email não encontrado!');
        //'Email não encontrado!';
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta!');
        //'Senha incorreta!';
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 0, 67),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          top: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const OlaMerma(
                  title: 'Vamos verificar seu email',
                  usetext: false,
                  text: '',
                ),

                //Email TextField
                EmailField(
                  controller: _emailController,
                ),

                const SizedBox(height: 40),

                //VerifyButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      _emailController.toString().isEmpty
                          ?
                          //adicionar alerta >> snackbar
                          print('Email textfield vazio!')
                          : signIn().whenComplete(
                              () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const NewUserPage()));
                              },
                            );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 0, 67),
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 199, 248)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Verificar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 221, 199, 248),
                              fontFamily: 'Poppins',
                              //fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
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
