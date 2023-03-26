import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/core/auth/check_login.dart';
import 'package:mermas_digitais_app/src/models/navbar/navbar.dart';
import 'package:mermas_digitais_app/src/screens/loginPages/login_page.dart';
import 'package:mermas_digitais_app/src/screens/loginPages/new_user_page.dart';
import 'package:mermas_digitais_app/src/screens/loginPages/verify_email.dart';
import 'package:mermas_digitais_app/src/screens/menuPages/comunicados_page.dart';
import 'package:mermas_digitais_app/src/screens/menuPages/frequencia_page.dart';
import 'package:mermas_digitais_app/src/screens/menuPages/oficinas_page.dart';
import 'package:mermas_digitais_app/src/screens/menuPages/perfil_page.dart';

import '../models/frequence_windows/new_frequence_window.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'auth': (context) => const CheckLogin(),
  'login': (context) => const LoginPage(),
  'newUser': (context) => const NewUserPage(),
  'verifyEmail': (context) => const VerifyEmail(),
  'comunicados': (context) => const ComunicadosPage(),
  'frequencia': (context) => const FrequenciaPage(),
  'oficinas': (context) => const OficinasPage(),
  'perfil': (context) => const PerfilPage(),
  'navbar': (context) => const Navbar(),
  'addStudents': (context) => const CreateFrequenceWindow(),
};
