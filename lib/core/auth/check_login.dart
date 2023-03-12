import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/screens/loginPages/login_page.dart';
import 'package:mermas_digitais_app/src/models/navbar/navbar.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
