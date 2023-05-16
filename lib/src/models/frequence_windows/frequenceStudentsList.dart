// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FrequenceStudentsList extends StatefulWidget {
  const FrequenceStudentsList({super.key});

  @override
  State<FrequenceStudentsList> createState() => _FrequenceStudentsListState();
}

class _FrequenceStudentsListState extends State<FrequenceStudentsList> {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text(
        'Lista de alunos',
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: Text(
        'Em breve...',
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "Poppins",
          //fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
