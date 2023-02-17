import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mermas_digitais_app/homePage.dart';
import 'firebase_options.dart';

/*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
