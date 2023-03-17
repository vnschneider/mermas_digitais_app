// ignore_for_file: file_names

import 'package:mermas_digitais_app/core/exports/login_page_exports.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Lista de alunas",
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "PaytoneOne",
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'content',
            style: TextStyle(
              color: Color.fromARGB(255, 51, 0, 67),
              fontFamily: "Poppins",
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
