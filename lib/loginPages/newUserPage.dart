import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mermas_digitais_app/loginPages/loginPage.dart';
import 'package:mermas_digitais_app/menuPages/homePage.dart';
import 'package:mermas_digitais_app/models/loadingWindow.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NewUserPage extends StatelessWidget {
  const NewUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(0),
      maintainBottomViewPadding: true,
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          //controller: _emailController,
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
                          //controller: _passwordController,
                          // obscureText: showpassword,
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextField(
                          //controller: _passwordController,
                          //obscureText: showpassword,
                          decoration: InputDecoration(
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
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          Navigator.of(context).pop();
                        });
                        Future.delayed(const Duration(milliseconds: 800), () {
                          Navigator.of(context).pop();
                        });
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
