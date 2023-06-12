import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/classesFunctions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../functions/get_user_info.dart';
import '../../utils/showToastMessage.dart';
import '../alertDialogs/alertDialogs.dart';
import '../class_menu_windows/class_menu_windows.dart';
import '../searchAppBar/searchAppBar.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  ClassOptions classOptions = ClassOptions();
  GetUserInfo userInfo = GetUserInfo();
  final _searchController = TextEditingController();
  String className = '';
  bool loading = true;

  _launchUrl(Uri url) async {
    try {
      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await canLaunchUrl(url);
      }
    } catch (e) {
      showToastMessage(message: 'Não foi possível abrir o link.');
    }
  }

  Future<String> getClassInfo(String classUID) async {
    try {
      var classInfo = await FirebaseFirestore.instance
          .collection('classes')
          .doc(classUID)
          .get();

      final data = classInfo.data() as Map<String, dynamic>;

      if (loading == true) {
        setState(() {
          className = data['classTitle'];
        });
      } else {
        loading = false;
      }

      return className;
    } catch (e) {
      return 'Erro ao carregar a página';
    }
  }

  @override
  void initState() {
    userInfo.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      getClassInfo(ModalRoute.of(context)!.settings.arguments as String)
          .then((value) => className = value)
          .whenComplete(() => loading = false);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(22.0),
            bottomRight: Radius.circular(22.0),
          ),
          child: AppBar(
            title: className == ''
                ? const Text('Carregando...')
                : Text(
                    className.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .doc(ModalRoute.of(context)!.settings.arguments as String)
            .collection('classContent')
            .orderBy(FieldPath.fromString('createDate'))
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar a página'),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Não há material de apoio cadastrado'),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SearchBarWidget(
                    controller: _searchController,
                    hintText: 'Insira um nome para buscar',
                    onChanged: (String value) {},
                    text: '',
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot doc =
                              snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Card(
                              color: const Color.fromARGB(255, 221, 199, 248),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    doc['contentName']
                                                        .toString(),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                        fontFamily:
                                                            "PaytoneOne",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(child: SizedBox()),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        'Oficina: ${doc['contentDescription'].toString()}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 51, 0, 67),
                                                          fontFamily: "Poppins",
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Criada em  ${doc['displayDate'].toString()} Por ${doc['displayAutor'].toString()}',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            _launchUrl(
                                                                Uri.parse(doc[
                                                                        'link']
                                                                    .toString()));
                                                          },
                                                          child: const Text(
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            'Link do material',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      51,
                                                                      0,
                                                                      67),
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                            child: SizedBox()),
                                                        userInfo.userLevel ==
                                                                'Admin'
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return CustomAlertDialog(
                                                                            title:
                                                                                'Tem certeza que deseja excluir esse material de apoio?',
                                                                            content:
                                                                                'Atenção. Essa ação não poderá ser desfeita!',
                                                                            userActions:
                                                                                true,
                                                                            asyncType:
                                                                                false,
                                                                            function:
                                                                                () async {
                                                                              classOptions.deleteClassContentDB(doc['classUID'].toString(), doc['contentName'].toString());
                                                                              Navigator.of(context).pop();
                                                                              showToastMessage(message: 'Material de aula excluído');
                                                                            });
                                                                      });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  BootstrapIcons
                                                                      .trash,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          51,
                                                                          0,
                                                                          67),
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          //const SizedBox(height: 10),
                        }),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Erro ao carregar a página'),
          );
        },
      ),
      floatingActionButton: userInfo.userLevel == 'Admin'
          ? FloatingActionButton(
              tooltip: 'Adicionar material de apoio',
              elevation: 2,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return NewClassContentWindow(classUID: className);
                  },
                );
              },
              child: const Icon(
                BootstrapIcons.plus,
                size: 26,
              ))
          : null,
    );
  }
}
