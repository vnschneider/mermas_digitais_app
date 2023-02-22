import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mermas_digitais_app/loginPages/loginPage.dart';
import 'package:mermas_digitais_app/menuPages/homePage.dart';
import 'firebase_options.dart';
import 'loginPages/checkLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomAppBarColor: Color.fromARGB(255, 221, 199, 248),
        primarySwatch: Colors.deepPurple,
      ),
      home: CheckLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
