import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mermas_digitais_app/src/loginPages/new_user_page.dart';
import 'package:mermas_digitais_app/src/models/loading_window.dart';

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
    Navigator.of(context).pop();
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
                //logo
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
                const Text(
                  'Vamos verificar seu email',
                  style: TextStyle(
                      color: Color.fromARGB(255, 221, 199, 248),
                      fontFamily: 'Poppins',
                      //fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 50),

                //Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 0, 67),
                      border: Border.all(
                          color: const Color.fromARGB(200, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248)),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                //VerifyButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      signIn().whenComplete(
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
