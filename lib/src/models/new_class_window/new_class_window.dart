// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import '../../functions/get_user_info.dart';
import '../showToastMessage.dart';
import '../textFields/dialogs_text_fields.dart';

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
      builder: (context, snapshot) => Center(
        child: SingleChildScrollView(
          child: AlertDialog(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DialogTextField(
                  expanded: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  useController: true,
                  controller: _titleController,
                  hintText: 'Nome',
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  expanded: true,
                  keyboardType: TextInputType.multiline,
                  enabled: true,
                  useController: true,
                  controller: _classContentController,
                  hintText: 'Descrição',
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  expanded: false,
                  keyboardType: TextInputType.url,
                  enabled: true,
                  useController: true,
                  controller: _linkController,
                  hintText: 'Link do material de apoio',
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
                        .whenComplete(() {
                      showToastMessage(message: 'Oficina adicionada!');
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
        ),
      ),
    );
  }
}
