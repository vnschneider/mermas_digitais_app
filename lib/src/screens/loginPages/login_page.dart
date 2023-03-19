// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/core/exports/login_page_exports.dart';
import 'package:mermas_digitais_app/src/models/snack_bar/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Duration duration = const Duration(seconds: 3);
  bool _showPassword = true;

  Future signIn() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        },
      );
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, 'auth', ModalRoute.withName('/')));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        scaffoldMessenger(
          context: context,
          duration: duration,
          text: "Email não encontrado!",
        );
      } else if (e.code == 'wrong-password') {
        scaffoldMessenger(
          context: context,
          duration: duration,
          text: "Senha incorreta!",
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
  }

  ///MODULARIZAR/////
  changePassword() {
    return AlertDialog(
      title: const Text(
        "Deseja alterar sua senha?",
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "PaytoneOne",
          fontSize: 16,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              hintText: 'Email',
              enabled: true,
              useController: true),
          const Text(
            "Enviaremos um email solicitando uma nova senha. Confira sua caixa de entrada!",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color.fromARGB(255, 51, 0, 67),
              fontFamily: "Poppins",
              fontSize: 14,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_emailController.text.isNotEmpty &&
                EmailValidator.validate(_emailController.text)) {
              try {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _emailController.text);
              } catch (e) {
                return print("Algo deu errado $e");
              }
              Navigator.of(context).pop();
            } else {
              _emailController.clear();
              scaffoldMessenger(
                context: context,
                duration: duration,
                text: "Insira um email válido!",
              );
            }
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 0, 67),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        reverse: true,
        padding:
            const EdgeInsets.only(top: 150, right: 20, left: 20, bottom: 20),
        children: [
          Center(
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
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  expanded: false,
                  useController: true,
                  enabled: true,
                  controller: _emailController,
                  hintText: "Email",
                ),
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
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              showPassword();
                            },
                            child: Icon(
                              _showPassword == true
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                              color: const Color.fromARGB(200, 221, 199, 248),
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
                //Esqueceu sua senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return changePassword();
                            },
                          );
                        },
                        child: const Text(
                          'Esqueci minha senha',
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
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWindow();
                            });
                        signIn();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 221, 199, 248),
                              title: Text(
                                "Algo deu errado!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 51, 0, 67),
                                ),
                              ),
                              content: Text(
                                "Tenha certeza de que preencheu os campos corretamente.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 51, 0, 67),
                                ),
                              ),
                            );
                          },
                        );
                      }
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
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'verifyEmail');
                  },
                  child: const Text(
                    'Seu primeiro acesso?',
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
        ],
      ),
    );
  }
}
