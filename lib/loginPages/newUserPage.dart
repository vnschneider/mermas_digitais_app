// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mermas_digitais_app/models/loadingWindow.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        });
    try {
      //create user
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        //add user details
        addUserDetails(_nameController.text.trim(),
            FirebaseAuth.instance.currentUser!.email.toString());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Email não encontrado!');
        //'Email não encontrado!';
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta!');
        //'Senha incorreta!';
      } else if (e.code == 'auth/email-already-exists') {
        UpdateUser();
        //add user details
        addUserDetails(_nameController.text.trim(),
            FirebaseAuth.instance.currentUser!.email.toString());
      }
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future UpdateUser() async {
    await FirebaseAuth.instance.currentUser!
        .updatePassword(_passwordController.text.trim());
    addUserDetails(_nameController.text.trim(),
        FirebaseAuth.instance.currentUser!.email.toString());
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future addUserDetails(String name, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'email': email,
      'name': name,
      'frequence': 1.0,
      'status': 'Aluna',
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 51, 0, 67),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SafeArea(
            top: false,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    'Conclua seu cadastro para consultar suas faltas e muito mais.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 221, 199, 248),
                        fontFamily: 'Poppins',
                        //fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 50),
                  //UID TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 0, 67),
                        border: Border.all(
                            color: const Color.fromARGB(200, 221, 199, 248)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Seu UID: ',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 221, 199, 248)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Name TextField
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
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nome',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 221, 199, 248)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

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
                        child: TextField(
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
                  const SizedBox(height: 20),

                  //Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 0, 67),
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 199, 248)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.remove_red_eye_sharp,
                                color: Color.fromARGB(200, 221, 199, 248),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Senha',
                            hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 221, 199, 248)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Confirm Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 0, 67),
                        border: Border.all(
                            color: const Color.fromARGB(255, 221, 199, 248)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirmar senha',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 221, 199, 248)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  //RegisterButton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWindow();
                            });
                        UpdateUser()
                            .whenComplete(() => Navigator.of(context).pop());
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
                            'Cadastrar',
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
      ),
    );
  }
}
