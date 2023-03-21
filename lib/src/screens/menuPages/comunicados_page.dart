import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mermas_digitais_app/src/functions/postFunctions.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/post_menu_windows/post_menu_windows.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';
import 'package:url_launcher/url_launcher.dart';

class ComunicadosPage extends StatefulWidget {
  const ComunicadosPage({super.key});

  @override
  State<ComunicadosPage> createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  final isDialOpen = ValueNotifier(false);

  GetUserInfo userInfo = GetUserInfo();
  PostOptions postOptions = PostOptions();

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
                              child: Card(
                                color: const Color.fromARGB(255, 221, 199, 248),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                doc['postTitle'].toString(),
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
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
                                      const SizedBox(height: 10),
                                      ExpandableText(
                                        doc['postContent'].toString(),
                                        maxLines: 4,
                                        textAlign: TextAlign.start,
                                        // overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 51, 0, 67),
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                        ),
                                        linkStyle: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        expandText: 'mostrar mais',
                                        collapseText: 'mostrar menos',
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          doc['postLink'].toString().isNotEmpty
                                              ? TextButton(
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
                                                    textAlign: TextAlign.start,
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
                                                )
                                              : const SizedBox(),
                                          userInfo.userStatus == 'Admin'
                                              ? Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return EditPostWindow(
                                                                  postTitle: doc[
                                                                      'postTitle'],
                                                                  postUID: doc[
                                                                      'postUID'],
                                                                  postContent: doc[
                                                                      'postContent'],
                                                                  postLink: doc[
                                                                      'postLink']);
                                                            });
                                                      },
                                                      child: const Icon(
                                                        BootstrapIcons
                                                            .pencil_square,
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return DeletePostDBWindow(
                                                              Title:
                                                                  'Deseja apagar este comunicado?',
                                                              Content:
                                                                  'Atenção! Essa alteração não poderá ser desfeita.',
                                                              postUID: doc[
                                                                  'postUID'],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        BootstrapIcons.trash3,
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
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
            floatingActionButton: userInfo.userStatus == 'Admin'
                ? SpeedDial(
                    heroTag: 'postTag',
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
                            return const CreatePostWindow();
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
