import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import '../../functions/frequence_functions.dart';
import '../../functions/get_user_info.dart';
import '../loading_window/loading_window.dart';
import '../../utils/showToastMessage.dart';
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

///FUNÇÃO QUE CRIA UMA AULA////
class CreateFrequenceWindow extends StatefulWidget {
  const CreateFrequenceWindow({super.key, required this.frequenceUID});
  final String frequenceUID;

  @override
  State<CreateFrequenceWindow> createState() => _CreateFrequenceWindowState();
}

class _CreateFrequenceWindowState extends State<CreateFrequenceWindow> {
  final user = FirebaseAuth.instance;

  String startDate = DateTime.now().toString();
  GetUserInfo userInfo = GetUserInfo();
  FrequenceOptions frequenceOptions = FrequenceOptions();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: CustomAppBar(text: "Lista de alunas")),
          body: !snapshot.hasData
              ? const LoadingWindow()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            color: const Color.fromARGB(255, 221, 199, 248),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      doc['profilePhoto'].toString().isNotEmpty
                                          ? CachedNetworkImage(
                                              memCacheHeight: 2000,
                                              memCacheWidth: 2000,
                                              progressIndicatorBuilder: (context,
                                                      url, progress) =>
                                                  const SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Color.fromARGB(
                                                            255, 221, 199, 248),
                                                      )),

                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                BootstrapIcons.person_circle,
                                                size: 50,
                                                color: Color.fromARGB(
                                                    255, 51, 0, 67),
                                              ),
                                              // fit: BoxFit.cover,
                                              imageUrl: doc['profilePhoto'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              progressIndicatorBuilder: (context,
                                                      url, progress) =>
                                                  const SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Color.fromARGB(
                                                            255, 221, 199, 248),
                                                      )),

                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                BootstrapIcons.person_circle,
                                                size: 50,
                                                color: Color.fromARGB(
                                                    255, 51, 0, 67),
                                              ),
                                              // fit: BoxFit.cover,
                                              imageUrl:
                                                  'https://firebasestorage.googleapis.com/v0/b/mermas-digitais-2023.appspot.com/o/fundo-roxo-v.png?alt=media&token=32460753-3c18-46fc-be25-d682f3af5ad6',

                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          //  mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  doc['name'],
                                                  maxLines: 1,
                                                  textAlign: TextAlign.start,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 51, 0, 67),
                                                      fontFamily: "PaytoneOne",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          //mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              'UserLevel: ${doc['userLevel'].toString()}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 0, 67),
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      frequenceOptions.addMissignStudent(
                                          doc['userUID'].toString(),
                                          widget.frequenceUID);

                                      showToastMessage(
                                          message:
                                              'Falta adicionada ao usuário');
                                    },
                                    child: const Icon(BootstrapIcons.plus),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ),
      ),
    );
  }
}

///FUNÇÃO QUE EDITA UMA AULA////
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
/*
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
}*/
