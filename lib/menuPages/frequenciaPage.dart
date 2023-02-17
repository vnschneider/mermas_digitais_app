import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FrequenciaPage extends StatefulWidget {
  const FrequenciaPage({super.key});

  @override
  State<FrequenciaPage> createState() => _FrequenciaPageState();
}

class _FrequenciaPageState extends State<FrequenciaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Frequência'),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: Center(
        child: Text('Frequenncia'),
      ),
    );
  }
}
