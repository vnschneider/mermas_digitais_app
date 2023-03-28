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
      title: Text('Lista de alunos'),
      content: Text('alunos'),
    );
  }
}
