// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import '../../functions/classesFunctions.dart';
import '../../functions/get_user_info.dart';
import '../../utils/showToastMessage.dart';
import '../textFields/dialogs_text_fields.dart';

class NewClassWindow extends StatefulWidget {
  const NewClassWindow({super.key});

  @override
  State<NewClassWindow> createState() => _NewClassWindowState();
}

class _NewClassWindowState extends State<NewClassWindow> {
  final _titleController = TextEditingController();
  final _descriController = TextEditingController();
  final _classContentController = TextEditingController();
  final user = FirebaseAuth.instance;
  String dateTime = DateTime.now().toString();
  GetUserInfo userInfo = GetUserInfo();
  ClassOptions classOptions = ClassOptions();

  @override
  void dispose() {
    _titleController.dispose();
    _descriController.dispose();
    _classContentController.dispose();
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
                      _classContentController.text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWindow();
                        });
                    classOptions
                        .createClassDB(
                            _titleController.text, _classContentController.text)
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

class DeleteClassDBWindow extends StatefulWidget {
  const DeleteClassDBWindow({super.key, required this.classUID});
  final String classUID;

  @override
  State<DeleteClassDBWindow> createState() => _DeleteClassDBWindowState();
}

class _DeleteClassDBWindowState extends State<DeleteClassDBWindow> {
  ClassOptions classOptions = ClassOptions();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text(
          "Deseja apagar esta oficina?",
          style: TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 20,
          ),
        ),
        content: Text(
          'Você está prestes a excluir o item: ${widget.classUID.toString()}. Atenção! Essa alteração não poderá ser desfeita ',
          style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "Poppins",
            fontSize: 16,
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
              classOptions.deleteClassDB(widget.classUID).whenComplete(() {
                showToastMessage(message: 'Oficina excluída!');
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

//NewClassContentWindow
class NewClassContentWindow extends StatefulWidget {
  const NewClassContentWindow({super.key, required this.classUID});
  final String classUID;

  @override
  State<NewClassContentWindow> createState() => _NewClassContentWindowState();
}

class _NewClassContentWindowState extends State<NewClassContentWindow> {
  final _titleController = TextEditingController();
  final _descriController = TextEditingController();
  final _classContentController = TextEditingController();
  final _linkController = TextEditingController();
  final user = FirebaseAuth.instance;
  String dateTime = DateTime.now().toString();
  GetUserInfo userInfo = GetUserInfo();
  ClassOptions classOptions = ClassOptions();

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
              "Novo material de apoio",
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
                  hintText: 'Título da aula',
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
                  hintText: 'Link do material',
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
                    classOptions
                        .createClassContentDB(
                            widget.classUID,
                            _titleController.text,
                            _classContentController.text,
                            _linkController.text,
                            userInfo.userName)
                        .whenComplete(() {
                      showToastMessage(
                          message: 'Marterial de apoio adicionado!');
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
