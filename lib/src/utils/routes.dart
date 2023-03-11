import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/core/exports/main_exports.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'auth': (context) => const CheckLogin(),
  'login': (context) => const LoginPage(),
  'newUser': (context) => const NewUserPage(),
  'verifyEmail': (context) => const VerifyEmail(),
  'comunicados': (context) => const ComunicadosPage(),
  'frequencia': (context) => const FrequenciaPage(),
  'home': (context) => const HomePage(),
  'oficinas': (context) => const OficinasPage(),
  'perfil': (context) => const PerfilPage(),
  'navbar': (context) => const Navbar(),
};
