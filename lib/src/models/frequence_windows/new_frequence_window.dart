// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NewFrequenceWindow extends StatefulWidget {
  const NewFrequenceWindow({super.key});

  @override
  State<NewFrequenceWindow> createState() => _NewFrequenceWindowState();
}

class _NewFrequenceWindowState extends State<NewFrequenceWindow> {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text(
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
        children: [
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


// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/postFunctions.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';

import '../textFields/dialogs_text_fields.dart';

///FUNÇÃO QUE CRIA UM POST////
class CreatePostWindow extends StatefulWidget {
  const CreatePostWindow({super.key});

  @override
  State<CreatePostWindow> createState() => _CreatePostWindowState();
}

class _CreatePostWindowState extends State<CreatePostWindow> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  final user = FirebaseAuth.instance;
  final postUID = '';
  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  GetUserInfo userInfo = GetUserInfo();

  PostOptions postOptions = PostOptions();

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
                    const SizedBox(width: 10),
                    Switch(
                      thumbColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 221, 199, 248),
                      ),
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
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
                  controller: _contentController,
                  hintText: 'Conteúdo',
                ),
                const SizedBox(height: 10),
                isSwitched == false
                    ? const SizedBox()
                    : DialogTextField(
                        expanded: false,
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
                    postOptions
                        .createPostDB(_titleController.text,
                            _contentController.text, _linkController.text)
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
        ),
      ),
    );
  }
}

///FUNÇÃO QUE EDITA UM POST////
class EditPostWindow extends StatefulWidget {
  const EditPostWindow(
      {super.key,
      required this.postTitle,
      required this.postUID,
      required this.postContent,
      required this.postLink});

  final String postTitle;
  final String postContent;
  final String postLink;
  final String postUID;

  @override
  State<EditPostWindow> createState() => _EditPostWindowState();
}

class _EditPostWindowState extends State<EditPostWindow> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _contentController = TextEditingController();

  late TextEditingController _linkController = TextEditingController();
  final user = FirebaseAuth.instance;

  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  GetUserInfo userInfo = GetUserInfo();
  PostOptions postOptions = PostOptions();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.postTitle);
    _contentController = TextEditingController(text: widget.postContent);
    _linkController = TextEditingController(text: widget.postLink);

    if (widget.postLink.isNotEmpty) isSwitched = !isSwitched;
    super.initState();
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
      builder: (context, snapshot) => Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            title: const Text(
              "Editar comunicado",
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
                    const SizedBox(width: 10),
                    Switch(
                      thumbColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 221, 199, 248),
                      ),
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                  controller: _contentController,
                  hintText: 'Conteúdo',
                ),
                const SizedBox(height: 10),
                isSwitched == false
                    ? const SizedBox()
                    : DialogTextField(
                        expanded: false,
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
                          _titleController.text != widget.postTitle ||
                      _contentController.text.isNotEmpty &&
                          _contentController.text != widget.postContent ||
                      _linkController.text != widget.postLink &&
                          (_linkController.text.isNotEmpty ||
                              isSwitched == false)) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWindow();
                        });
                    postOptions
                        .editPostDB(
                            _titleController.text,
                            _contentController.text,
                            _linkController.text,
                            widget.postUID)
                        .whenComplete(() {
                      showToastMessage(message: 'Comunicado atualizado!');
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

class DeletePostDBWindow extends StatefulWidget {
  const DeletePostDBWindow(
      {super.key,
      required this.Title,
      required this.Content,
      required this.postUID});

  final String Title;
  final String Content;
  final String postUID;

  @override
  State<DeletePostDBWindow> createState() => _DeletePostDBWindowState();
}

class _DeletePostDBWindowState extends State<DeletePostDBWindow> {
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
        widget.Content,
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
            if (widget.postUID.isNotEmpty) {
              postOptions.deletePostDB(widget.postUID).whenComplete(() {
                showToastMessage(message: 'Comunicado excluído com sucesso!');
                Navigator.of(context).pop();
              });
            }

            showToastMessage(message: 'O post selecionado não possui UID');
            Navigator.of(context).pop();
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}
