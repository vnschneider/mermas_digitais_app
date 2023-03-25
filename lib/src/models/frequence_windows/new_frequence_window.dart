// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../functions/frequence_functions.dart';
import '../../functions/get_user_info.dart';
import '../../functions/postFunctions.dart';
import '../loading_window/loading_window.dart';
import '../showToastMessage.dart';
import '../textFields/dialogs_text_fields.dart';

class NewFrequenceWindow extends StatefulWidget {
  const NewFrequenceWindow({super.key});

  @override
  State<NewFrequenceWindow> createState() => _NewFrequenceWindowState();
}

class _NewFrequenceWindowState extends State<NewFrequenceWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Nova frequência",
        style: TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "PaytoneOne",
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
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

///FUNÇÃO QUE CRIA UM POST////
class CreateFrequenceWindow extends StatefulWidget {
  const CreateFrequenceWindow({super.key});

  @override
  State<CreateFrequenceWindow> createState() => _CreateFrequenceWindowState();
}

class _CreateFrequenceWindowState extends State<CreateFrequenceWindow> {
  final _titleController = TextEditingController();
  final _classController = TextEditingController();
  final user = FirebaseAuth.instance;
  final frequenceUID = '';
  String startDate = DateTime.now().toString();
  GetUserInfo userInfo = GetUserInfo();

  FrequenceOptions frequenceOptions = FrequenceOptions();

  @override
  void dispose() {
    _titleController.dispose();
    _classController.dispose();
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
              "Novo comunicado",
              style: TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "PaytoneOne",
                fontSize: 20,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DialogTextField(
                  expanded: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  useController: true,
                  controller: _titleController,
                  hintText: 'Título',
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  expanded: true,
                  keyboardType: TextInputType.multiline,
                  enabled: true,
                  useController: true,
                  controller: _classController,
                  hintText: 'Conteúdo',
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
                      _classController.text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWindow();
                        });

                    frequenceOptions
                        .createFrequenceDB(_titleController.text,
                            _classController.text, userInfo.user.uid)
                        .whenComplete(() {
                      showToastMessage(message: 'Aula adicionada!');
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

///FUNÇÃO QUE EDITA UM POST////
class EditFrequenceWindow extends StatefulWidget {
  const EditFrequenceWindow(
      {super.key,
      required this.frequenceTitle,
      required this.classContent,
      required this.frequenceUID});

  final String frequenceTitle;
  final String classContent;

  final String frequenceUID;

  @override
  State<EditFrequenceWindow> createState() => _EditFrequenceWindowState();
}

class _EditFrequenceWindowState extends State<EditFrequenceWindow> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _classController = TextEditingController();

  final user = FirebaseAuth.instance;

  String startTime = DateTime.now().toString();

  GetUserInfo userInfo = GetUserInfo();
  FrequenceOptions frequenceOptions = FrequenceOptions();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.frequenceTitle);
    _classController = TextEditingController(text: widget.classContent);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _classController.dispose();
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
              "Editar aula",
              style: TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "PaytoneOne",
                fontSize: 20,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DialogTextField(
                  expanded: false,
                  keyboardType: TextInputType.text,
                  enabled: true,
                  useController: true,
                  controller: _titleController,
                  hintText: 'Título',
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  expanded: true,
                  keyboardType: TextInputType.multiline,
                  enabled: true,
                  useController: true,
                  controller: _classController,
                  hintText: 'Conteúdo',
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
                          _titleController.text != widget.frequenceTitle ||
                      _classController.text.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWindow();
                        });
                    frequenceOptions
                        .editFrequenceDB(_titleController.text,
                            _classController.text, 'Open', widget.frequenceUID)
                        .whenComplete(() {
                      showToastMessage(message: 'Aula atualizado!');
                      Navigator.of(context).pop();
                    });
                    Navigator.of(context).pop();
                  } else {
                    showToastMessage(
                        message:
                            'Tenha certeza de que alterou os dados do comunicado ou não deixou nenhum campo vazio.');
                  }
                },
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///FUNÇÃO QUE DELETA UM POST////

class DeleteFrequenceDBWindow extends StatefulWidget {
  const DeleteFrequenceDBWindow(
      {super.key,
      required this.Title,
      required this.frequenceClass,
      required this.frequenceUID});

  final String Title;
  final String frequenceClass;
  final String frequenceUID;

  @override
  State<DeleteFrequenceDBWindow> createState() =>
      _DeleteFrequenceDBWindowState();
}

class _DeleteFrequenceDBWindowState extends State<DeleteFrequenceDBWindow> {
  PostOptions postOptions = PostOptions();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 221, 199, 248),
      title: Text(
        widget.Title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      content: Text(
        widget.frequenceClass,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Color.fromARGB(255, 51, 0, 67),
          fontFamily: "Poppins",
          fontSize: 15,
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
                });
            if (widget.frequenceUID.isNotEmpty) {
              postOptions.deletePostDB(widget.frequenceUID).whenComplete(() {
                showToastMessage(message: 'Aula excluída com sucesso!');
                Navigator.of(context).pop();
              });
            }

            showToastMessage(message: 'A aula selecionada não possui UID');
            Navigator.of(context).pop();
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
