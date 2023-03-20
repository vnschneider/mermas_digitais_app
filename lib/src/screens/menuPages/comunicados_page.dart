import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/new_post_window/new_post_window.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/alertDialogs/alertDialogs.dart';

class ComunicadosPage extends StatefulWidget {
  const ComunicadosPage({super.key});

  @override
  State<ComunicadosPage> createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  final isDialOpen = ValueNotifier(false);
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
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
            WillPopScope(
          onWillPop: () async {
            if (isDialOpen.value) {
              //close speed dial
              isDialOpen.value = false;

              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: CustomAppBar(text: 'Comunicados'),
            ),
            body: SafeArea(
              child: !snapshot.hasData
                  ? const LoadingWindow()
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: GestureDetector(
                                onLongPress: () => showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PostAlertDialog(
                                      postTitle: doc['postTitle'],
                                      postContent: doc['postContent'],
                                      postLink: doc['postLink'],
                                    );
                                  },
                                ),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 221, 199, 248),
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
                                            Expanded(
                                              child: Text(
                                                doc['postTitle'].toString(),
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 51, 0, 67),
                                                    fontFamily: "PaytoneOne",
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
                                                doc['postContent'].toString(),
                                                maxLines: 4,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
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
                                        const SizedBox(height: 10),
                                        doc['postLink'].toString().isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      if (doc['postLink']
                                                          .toString()
                                                          .isNotEmpty) {
                                                        _launchUrl(Uri.parse(
                                                            doc['postLink']
                                                                .toString()));
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Mais sobre',
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
            ),
            floatingActionButton: userInfo.userStatus == 'Admin'
                ? SpeedDial(
                    tooltip: 'Menu',

                    openCloseDial: isDialOpen,
                    curve: Curves.elasticInOut,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.2,
                    buttonSize: const Size(58, 58),
                    //shape: const StadiumBorder(side: BorderSide.none),
                    icon: BootstrapIcons.menu_app,
                    activeIcon: BootstrapIcons.x,
                    children: [
                      SpeedDialChild(
                        child: const Icon(
                          BootstrapIcons.envelope_plus,
                          color: Color.fromARGB(255, 221, 199, 248),
                        ),
                        backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                        labelBackgroundColor:
                            const Color.fromARGB(255, 221, 199, 248),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 0, 67),
                            fontFamily: 'Poppins'),
                        label: 'Novo comunicado',
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return const NewPostWindow();
                          },
                        ),
                      ),
                      SpeedDialChild(
                        child: const Icon(
                          BootstrapIcons.send_plus,
                          color: Color.fromARGB(255, 221, 199, 248),
                        ),
                        backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                        labelBackgroundColor:
                            const Color.fromARGB(255, 221, 199, 248),
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 51, 0, 67),
                            fontFamily: 'Poppins'),
                        label: 'Nova notificação',
                        onTap: () => showToastMessage(
                            message:
                                'Em breve você poderá enviar notificações'),
                      )
                    ],
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
