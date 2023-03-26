import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/frequence_functions.dart';
import 'package:mermas_digitais_app/src/models/alertDialogs/alertDialogs.dart';
import 'package:mermas_digitais_app/src/models/frequence_windows/frequenceStudentsList.dart';

import '../../functions/get_user_info.dart';
import '../loading_window/loading_window.dart';
import '../searchAppBar/searchAppBar.dart';
import '../showToastMessage.dart';

class FrequenceList extends StatefulWidget {
  const FrequenceList({super.key});

  @override
  State<FrequenceList> createState() => _FrequenceListState();
}

class _FrequenceListState extends State<FrequenceList> {
  FrequenceOptions frequenceOptions = FrequenceOptions();
  GetUserInfo userInfo = GetUserInfo();
  final _searchController = TextEditingController();
  String searchValue = '';
  bool onSearch = false;
  String searchData = '';
  final DateTime date = DateTime.now();
  final List<String> _suggestionsList = [];

  frequenceFlag(endDate, frequenceUID) {
    if (date.isAfter(endDate)) {
      frequenceOptions.changeFrequenceFlag(frequenceUID, 'closed');

      return 'closed';
    } else {
      frequenceOptions.changeFrequenceFlag(frequenceUID, 'open');

      return 'open';
    }
  }

  Future loadSearchValue() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('frequences');
      var querySnap = await docRef.get();
      if (_suggestionsList.isEmpty) {
        for (var queryDocumentSnapshot in querySnap.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();

          _suggestionsList.add(data['frequenceTitle']);
        }
      }
    } catch (e) {
      showToastMessage(message: 'Não foi possível realizar esta operação.');
    }
  }

  @override
  void initState() {
    loadSearchValue();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: searchValue != ''
            ? FirebaseFirestore.instance
                .collection('frequences')
                .where(FieldPath.fromString('frequenceTitle'),
                    isEqualTo: searchValue)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('frequences')
                .orderBy(FieldPath.fromString('frequenceClass'))
                .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22.0),
                bottomRight: Radius.circular(22.0),
              ),
              child: EasySearchBar(
                onSuggestionTap: (data) {
                  onSearch = false;
                  searchData = data;
                },
                suggestionLoaderBuilder: () => const CircularProgressIndicator(
                  color: Colors.black,
                ),
                searchBackIconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 221, 199, 248),
                ),
                searchCursorColor: const Color.fromARGB(255, 221, 199, 248),
                suggestionBackgroundColor:
                    const Color.fromARGB(255, 221, 199, 248),
                suggestionTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 51, 0, 67),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                isFloating: true,
                backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                searchBackgroundColor: const Color.fromARGB(255, 51, 0, 67),
                searchHintText: 'Insira o título da aula',
                searchHintStyle: const TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
                searchTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                searchTextKeyboardType: TextInputType.name,
                title: const Text(
                  'Aulas registradas',
                  style: TextStyle(
                      color: Color.fromARGB(255, 221, 199, 248),
                      fontFamily: 'PaytoneOne',
                      //fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
                suggestions: _suggestionsList,
                onSearch: (value) => setState(() {
                  searchValue = value;
                  onSearch = true;
                }),
              ),
            ),
          ),
          body: !snapshot.hasData
              ? const LoadingWindow()
              : Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      doc['frequenceTitle']
                                                          .toString(),
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
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
                                                const Expanded(
                                                    child: SizedBox()),
                                                Text(
                                                  doc['frequenceFlag'] ==
                                                          'closed'
                                                      ? 'Fechada'
                                                      : 'Aberta',
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 51, 0, 67),
                                                    fontFamily: "Poppins",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        doc['frequenceFlag'] ==
                                                                'closed'
                                                            ? Colors.red
                                                            : Colors.green,
                                                  ),
                                                )
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          'Oficina: ${doc['frequenceClass'].toString()}',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    51,
                                                                    0,
                                                                    67),
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        'Criada em:  ${doc['frequenceStartDate'].toString()}',
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 51, 0, 67),
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        'Editável até:  ${doc['frequenceEndDateDisplay'].toString()}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 51, 0, 67),
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.start,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        'Criada por: ${doc['autorName'].toString()}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 51, 0, 67),
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
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
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return const FrequenceStudentsList();
                                                                  });
                                                            },
                                                            child: const Text(
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              'Lista de alunas',
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
                                                              child:
                                                                  SizedBox()),
                                                          userInfo.userStatus ==
                                                                  'Admin'
                                                              ? TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return CustomAlertDialog(
                                                                              title: 'Tem certeza que deseja excluir essa aula?',
                                                                              content: 'Atenção. Essa ação não poderá ser desfeita!',
                                                                              userActions: true,
                                                                              asyncType: false,
                                                                              function: () async {
                                                                                frequenceOptions.deleteFrequenceDB(doc['frequenceUID']);
                                                                                Navigator.of(context).pop();
                                                                                showToastMessage(message: 'Aula excluída');
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
        ),
      ),
    );
  }
}
