import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mermas_digitais_app/src/loginPages/verify_email.dart';
import 'package:mermas_digitais_app/src/models/loading_window.dart';
import 'package:mermas_digitais_app/src/models/textFields/email_field.dart';
import 'package:mermas_digitais_app/src/models/textFields/password_field.dart';
import 'package:mermas_digitais_app/src/models/ola_merma.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showpassword = true;
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
                  title: 'Bem vinda, mermã!',
                  usetext: true,
                  text: 'Consulte suas faltas e muito mais.',
                ),
                const SizedBox(height: 50),
                //Email TextField
                EmailField(
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                //Password TextField
                PasswordField(
                  controller: _passwordController,
                  showPassword: showpassword,
                ),
                const SizedBox(height: 5),

                //Esqueceu sua senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VerifyEmail(),
                          ));
                        },
                        child: const Text(
                          'Primeiro acesso ou esqueceu sua senha?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                //LoginButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      signIn();
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
                          'Entrar',
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
