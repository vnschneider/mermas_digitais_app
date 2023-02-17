import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Perfil'),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: Center(
        child: Text('Perfil'),
      ),
    );
  }
}
