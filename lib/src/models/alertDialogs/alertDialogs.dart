// ignore_for_file: file_names, non_constant_identifier_names, await_only_futures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../loading_window/loading_window.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.userActions,
    this.cancelButtonText,
    this.confirmButtonText,
    this.function,
    required this.asyncType,
    this.NavigatorPOPFunc,
  });

  final String title;
  final String content;
  final Text? cancelButtonText;
  final Text? confirmButtonText;
  final bool asyncType;
  final bool userActions;
  final Function? function;
  final bool? NavigatorPOPFunc;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 221, 199, 248),
        title: Text(
          widget.title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: "PaytoneOne",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 51, 0, 67),
          ),
        ),
        content: Text(
          widget.content,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Color.fromARGB(255, 51, 0, 67),
          ),
        ),
        actions: widget.userActions
            ? [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: widget.cancelButtonText ?? const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: widget.NavigatorPOPFunc == true
                      ? () {
                          Navigator.of(context).pop();
                        }
                      : () {
                          widget.function;
                        },
                  child: widget.confirmButtonText ?? const Text('Confirmar'),
                ),
              ]
            : null,
      ),
    );
  }
}

class ConfirmSignUpExit extends StatefulWidget {
  const ConfirmSignUpExit({
    super.key,
  });

  @override
  State<ConfirmSignUpExit> createState() => _ConfirmSignUpExitState();
}

class _ConfirmSignUpExitState extends State<ConfirmSignUpExit> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 221, 199, 248),
          title: const Text(
            'Deseja cancelar o cadastro?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 51, 0, 67),
            ),
          ),
          content: const Text(
            'Você será redirecionado para a tela de login e terá que refazer o processo de cadastro.',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: Color.fromARGB(255, 51, 0, 67),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LoadingWindow();
                  },
                );
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', ModalRoute.withName('/login')));
              },
              child: const Text('Confirmar'),
            ),
          ]),
    );
  }
}
