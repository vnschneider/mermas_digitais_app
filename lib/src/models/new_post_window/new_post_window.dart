import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';
import 'package:mermas_digitais_app/src/models/textFields/custom_text_field.dart';

class NewPostWindow extends StatefulWidget {
  const NewPostWindow({super.key});

  @override
  State<NewPostWindow> createState() => _NewPostWindowState();
}

class _NewPostWindowState extends State<NewPostWindow> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  final user = FirebaseAuth.instance;
  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  GetUserInfo userInfo = GetUserInfo();

  Future createPostDB(String title, content, link) async {
    await FirebaseFirestore.instance.collection('posts').doc(dateTime).set({
      'postTitle': title,
      'postContent': content,
      'postLink': link,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => AlertDialog(
        title: const Text(
          "Novo comunicado",
          style: TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Adicionar link',
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 0, 67),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  inactiveThumbColor: const Color.fromARGB(255, 221, 199, 248),
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            CustomTextField(
              expanded: false,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _titleController,
              hintText: 'Título',
            ),
            CustomTextField(
              expanded: true,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _contentController,
              hintText: 'Conteúdo',
            ),
            isSwitched == false
                ? const SizedBox()
                : CustomTextField(
                    expanded: true,
                    keyboardType: TextInputType.url,
                    enabled: true,
                    useController: true,
                    controller: _linkController,
                    hintText: 'Link',
                  )
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
                      _contentController.text.isNotEmpty &&
                      isSwitched == false ||
                  _linkController.text.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const LoadingWindow();
                    });
                createPostDB(_titleController.text, _contentController.text,
                        _linkController.text)
                    .whenComplete(() {
                  showToastMessage(message: 'Comunicado adicionado!');
                  Navigator.of(context).pop();
                });
                Navigator.of(context).pop();
              } else {
                showToastMessage(
                    message:
                        'Algo deu errado! Tenha certeza de que preencheu os campos corretamente.');
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
