import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/exports/frequencia_exports.dart';
import '../../functions/get_user_info.dart';
import '../../models/newPost_window/newPost_window.dart';

class ComunicadosPage extends StatefulWidget {
  const ComunicadosPage({super.key});

  @override
  State<ComunicadosPage> createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  GetUserInfo userInfo = GetUserInfo();

  _launchUrl(Uri url) async {
    if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
      await canLaunchUrl(url);
    } else {
      print("Não foi possível abrir o link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => Scaffold(
          appBar: AppBar(
            elevation: 3,
            toolbarHeight: 70,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            title: const Text(
              'Comunicados',
              style: TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: 'PaytoneOne',
                  //fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            backgroundColor: const Color.fromARGB(255, 51, 0, 67),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
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
                            const SizedBox(height: 20),
                            Card(
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
                                          doc['postTitle'].toString(),
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
                                            doc['postContent'].toString(),
                                            maxLines: 3,
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
                                              GestureDetector(
                                                onTap: () {
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
                                                    fontWeight: FontWeight.bold,
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
                          ],
                        );
                      }),
            ),
          ),
          floatingActionButton: userInfo.userStatus == 'Admin'
              ? FloatingActionButton(
                  tooltip: 'Novo comunicado',
                  elevation: 2,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const NewPostWindow();
                      },
                    );
                  },
                  child: const Icon(
                    BootstrapIcons.send_plus,
                    size: 38,
                  ))
              : null,
        ),
      ),
    );
  }
}
