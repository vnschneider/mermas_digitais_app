import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/alertDialogs/alertDialogs.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/textFields/custom_text_field.dart';

class EditUserProfileWindow extends StatelessWidget {
  const EditUserProfileWindow(
      {super.key,
      required this.userName,
      required this.userStatus,
      required this.userEmail});

  final String userName;
  final String userEmail;
  final String userStatus;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'StudentsListTag',
      child: AlertDialog(
        title: Text(
          userName,
          style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: const TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
            Text(
              userEmail,
              style: const TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
            Text(
              userStatus,
              style: const TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ],
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
                  });
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

class NewOficinaWindow extends StatefulWidget {
  const NewOficinaWindow({super.key});

  @override
  State<NewOficinaWindow> createState() => _NewOficinaWindowState();
}

class _NewOficinaWindowState extends State<NewOficinaWindow> {
  final _titleController = TextEditingController();
  final _descriController = TextEditingController();
  final _classContentController = TextEditingController();
  final _linkController = TextEditingController();
  final user = FirebaseAuth.instance;
  String dateTime = DateTime.now().toString();
  GetUserInfo userInfo = GetUserInfo();

  Future createPostDB(String title, content, link) async {
    await FirebaseFirestore.instance
        .collection('class')
        .doc(_titleController.text)
        .set({
      'classTitle': title,
      'classContent': content,
      'classLink': link,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriController.dispose();
    _classContentController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => AlertDialog(
        title: const Text(
          "Nova oficina",
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
            CustomTextField(
              expanded: false,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _titleController,
              hintText: 'Nome',
            ),
            CustomTextField(
              expanded: true,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _classContentController,
              hintText: 'Descrição',
            ),
            CustomTextField(
              expanded: true,
              keyboardType: TextInputType.url,
              enabled: true,
              useController: true,
              controller: _linkController,
              hintText: 'Link para o material de aula',
            ),
          ],
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
              if (_titleController.text.isNotEmpty &&
                  _classContentController.text.isNotEmpty &&
                  _linkController.text.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const LoadingWindow();
                    });
                createPostDB(_titleController.text,
                        _classContentController.text, _linkController.text)
                    .whenComplete(() => Navigator.of(context).pop());
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ErrorAlertDialog(
                      title: 'Algo deu errado!',
                      content:
                          'Tenha certeza de que preencheu os campos corretamente.',
                    );
                  },
                );
              }
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
