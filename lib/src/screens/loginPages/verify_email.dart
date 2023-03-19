import 'package:mermas_digitais_app/core/exports/verify_email_exports.dart';

import '../../models/snack_bar/snack_bar.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  //Text Controller
  final _emailController = TextEditingController();
  Duration duration = const Duration(seconds: 3);

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: 'test123',
          )
          .then(
            (value) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NewUserPage(),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffoldMessenger(
          context: context,
          duration: duration,
          text: "Email não encontrado!",
        );
        //'Email não encontrado!';
      } else if (e.code == 'wrong-password') {
        scaffoldMessenger(
          context: context,
          duration: duration,
          text: "Esse email já está cadastrado. Faça o login!",
        );

        //'Senha incorreta!';
      }
      Navigator.of(context).pop();
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
                CustomTextField(
                  expanded: false,
                  keyboardType: TextInputType.emailAddress,
                  useController: true,
                  enabled: true,
                  controller: _emailController,
                  hintText: "Email",
                ),

                const SizedBox(height: 20),

                //VerifyButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      _emailController.text.isNotEmpty
                          ? signIn()
                          //adicionar alerta >> snackbar

                          : showDialog(
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
