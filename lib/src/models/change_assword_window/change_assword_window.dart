import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GetUserInfo userInfo = GetUserInfo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => AlertDialog(
        title: const Text(
          "Deseja alterar sua senha?",
          style: TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 16,
          ),
        ),
        content: Text(
          "Enviaremos um email solicitando uma nova senha. Confira sua caixa de entrada em: ${userInfo.userEmail}",
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "Poppins",
            fontSize: 14,
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
              try {
                FirebaseAuth.instance.sendPasswordResetEmail(
                    email: userInfo.user.email.toString());
                Navigator.of(context).pop();
              } catch (e) {
                return print("Algo deu errado $e");
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
