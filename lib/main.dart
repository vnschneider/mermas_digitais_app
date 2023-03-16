import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mermas_digitais_app/core/firebase/firebase_options.dart';
import 'package:mermas_digitais_app/src/utils/theme_data.dart';
import 'package:mermas_digitais_app/src/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      routes: routes,
      initialRoute: 'newUser',
      debugShowCheckedModeBanner: false,
    );
  }
}
