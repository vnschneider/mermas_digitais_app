import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/class_menu_windows/class_menu_windows.dart';
import '../../utils/showToastMessage.dart';

class OficinasPage extends StatefulWidget {
  const OficinasPage({super.key});

  @override
  State<OficinasPage> createState() => _OficinasPageState();
}

class _OficinasPageState extends State<OficinasPage> {
  GetUserInfo userInfo = GetUserInfo();

  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .orderBy(FieldPath.fromString('classTitle'))
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(65),
            child: CustomAppBar(text: 'Oficinas'),
          ),
          body: SafeArea(
            child: !snapshot.hasData
                ? const LoadingWindow()
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot doc = snapshot.data!.docs[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Card(
                              color: const Color.fromARGB(255, 221, 199, 248),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['classTitle'].toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "PaytoneOne",
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: ExpandableText(
                                            doc['classContent'].toString(),
                                            maxLines: 4,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                            ),
                                            linkStyle: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                            expandText: 'mostrar mais',
                                            collapseText: 'mostrar menos',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          //ALTERNATIVE STYLE
                                          /*  style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 51, 0, 67))),*/
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                'classPage',
                                                arguments: doc['classUID']);
                                       
                                          },
                                          child: const Text(
                                            'Material de apoio',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        TextButton(
                                          //ALTERNATIVE STYLE
                                          /*  style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 51, 0, 67))), */
                                          onPressed: () {
                                            showToastMessage(
                                                message:
                                                    'Em breve você poderá acessar esta função');
                                          },
                                          child: const Text(
                                            'Monitores',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const Expanded(child: SizedBox()),
                                        userInfo.userLevel == 'Admin'
                                            ? TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return DeleteClassDBWindow(
                                                        classUID:
                                                            doc['classUID'],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Icon(
                                                  BootstrapIcons.trash3,
                                                  color: Color.fromARGB(
                                                      255, 51, 0, 67),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
          ),
          floatingActionButton: userInfo.userLevel == 'Admin'
              ? FloatingActionButton(
                  tooltip: 'Nova oficina',
                  elevation: 2,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const NewClassWindow();
                      },
                    );
                  },
                  child: const Icon(
                    BootstrapIcons.journal_plus,
                    size: 26,
                  ))
              : null,
        ),
      ),
    );
  }
}
