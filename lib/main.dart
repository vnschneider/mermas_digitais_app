import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'services/checkLogin.dart';

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
        useMaterial3: true,

        //light scheme
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 51, 0, 68),
          onPrimary: Color.fromARGB(255, 221, 199, 248),
          secondary: Color.fromARGB(255, 221, 199, 248),
          onSecondary: Color.fromARGB(255, 51, 0, 68),
          error: Color.fromARGB(255, 186, 26, 26),
          onError: Color.fromARGB(255, 255, 218, 214),
          background: Color.fromARGB(255, 255, 255, 255),
          onBackground: Color.fromARGB(255, 51, 0, 68),
          surface: Color.fromARGB(255, 51, 0, 68),
          onSurface: Color.fromARGB(255, 221, 199, 248),
        ),
      ),
      home: const CheckLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
