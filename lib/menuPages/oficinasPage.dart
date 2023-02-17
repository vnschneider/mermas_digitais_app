import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OficinasPage extends StatefulWidget {
  const OficinasPage({super.key});

  @override
  State<OficinasPage> createState() => _OficinasPageState();
}

class _OficinasPageState extends State<OficinasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Oficinas'),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: Center(
        child: Text('Oficinas'),
      ),
    );
  }
}
