import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/navbar/navbar.dart';
import 'package:mermas_digitais_app/src/screens/loginPages/login_page.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final onPop = ValueNotifier(false);
    return WillPopScope(
      onWillPop: () async {
        if (onPop.value) {
          showDialog(
            context: context,
            builder: (context) {
              return exitAppDialog(context);
            },
          );
          //close speed dial
          onPop.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Navbar();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}

@override
Widget exitAppDialog(BuildContext context) {
  return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 221, 199, 248),
      title: const Text(
        'Title',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: "PaytoneOne",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 51, 0, 67),
        ),
      ),
      content: const Text(
        'Content',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 14,
          color: Color.fromARGB(255, 51, 0, 67),
        ),
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
            Navigator.of(context).pop();
          },
          child: const Text('Confirmar'),
        ),
      ]);
}
