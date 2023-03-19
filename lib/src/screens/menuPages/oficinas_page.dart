import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/new_class_window/new_class_window.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';
import 'package:url_launcher/url_launcher.dart';

class OficinasPage extends StatefulWidget {
  const OficinasPage({super.key});

  @override
  State<OficinasPage> createState() => _OficinasPageState();
}

class _OficinasPageState extends State<OficinasPage> {
  GetUserInfo userInfo = GetUserInfo();

  _launchUrl(Uri url) async {
    try {
      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await canLaunchUrl(url);
      }
    } catch (e) {
      showToastMessage(message: 'Não foi possível abrir o link. Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('class').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(text: 'Oficinas'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: !snapshot.hasData
                  ? const LoadingWindow()
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              //height: 130,
                              child: Card(
                                color: const Color.fromARGB(255, 221, 199, 248),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          Expanded(
                                            child: Text(
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              doc['classContent'].toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 0, 67),
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                              ),
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
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            255, 51, 0, 67))),
                                            onPressed: () {
                                              _launchUrl(Uri.parse(
                                                  doc['classLink'].toString()));
                                            },
                                            child: const Text(
                                              'Material de apoio',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 221, 199, 248),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          TextButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            255, 51, 0, 67))),
                                            onPressed: () {},
                                            child: const Text(
                                              'Monitores',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 221, 199, 248),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
            ),
          ),
          floatingActionButton: userInfo.userStatus == 'Admin'
              ? FloatingActionButton(
                  tooltip: 'Nova oficina',
                  elevation: 2,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const NewOficinaWindow();
                      },
                    );
                  },
                  child: const Icon(
                    BootstrapIcons.journal_plus,
                    size: 36,
                  ))
              : null,
        ),
      ),
    );
  }
}
