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
          elevation: 3,
          toolbarHeight: 70,
          title: Text(
            'Oficinas',
            style: TextStyle(
                color: Color.fromARGB(255, 221, 199, 248),
                fontFamily: 'PaytoneOne',
                //fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: Center(
        child: Text('Oficinas'),
      ),
    );
  }
}
