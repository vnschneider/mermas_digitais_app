// ignore_for_file: file_names

import 'package:mermas_digitais_app/core/exports/login_page_exports.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 221, 199, 248),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 51, 0, 67),
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 51, 0, 67),
            ),
          ),
        ),
      ),
    );
  }
}
