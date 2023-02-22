import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextController
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Emaail não encontrado!');
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta!');
      }
    }
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
                //logo
                SvgPicture.asset(
                  'assets/logo_branca.svg',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),

                //Ola merma
                Text(
                  'Bem vinda mermã!',
                  style: TextStyle(
                      color: Color.fromARGB(255, 221, 199, 248),
                      fontFamily: 'PaytoneOne',
                      //fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),

                //Bemvinda
                SizedBox(height: 5),
                Text(
                  'Consulte suas faltas e muito mais.',
                  style: TextStyle(
                      color: Color.fromARGB(255, 221, 199, 248),
                      fontFamily: 'Poppins',
                      //fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(height: 50),

                //Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 51, 0, 67),
                      border:
                          Border.all(color: Color.fromARGB(255, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
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
                SizedBox(height: 20),

                //Password TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 51, 0, 67),
                      border:
                          Border.all(color: Color.fromARGB(255, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: showpassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                showpassword = false;
                              });
                              print(showpassword);
                            },
                            child: Icon(
                              Icons.remove_red_eye_sharp,
                              color: Color.fromARGB(255, 221, 199, 248),
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                //Esqueceu sua senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                //LoginButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 51, 0, 67),
                        border: Border.all(
                            color: Color.fromARGB(255, 221, 199, 248)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
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
