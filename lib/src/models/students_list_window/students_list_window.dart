import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/edit_user_profile_window/edit_user_profile_window.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  GetUserInfo userInfo = GetUserInfo();
  final _searchController = TextEditingController();
  String searchValue = '';
  bool onSearch = false;

  Future loadSearchValue() async {
    try {} catch (e) {
      print('Não foi possível pegar sugestões: $e');
    }
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
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => !snapshot
                .hasData
            ? const LoadingWindow()
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(65),
                  child: EasySearchBar(
                    isFloating: true,
                    backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                    searchBackgroundColor: const Color.fromARGB(255, 51, 0, 67),
                    searchHintText: 'Insira um nome',
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
                      'Usuários',
                      style: TextStyle(
                          color: Color.fromARGB(255, 221, 199, 248),
                          fontFamily: 'PaytoneOne',
                          //fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    suggestions: List.empty(),
                    onSearch: (value) => setState(() {
                      searchValue = value;
                      onSearch = true;
                    }),
                  ),
                ),
                body: SafeArea(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Hero(
                            tag: 'StudentsListTag',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    doc['name'].toString(),
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
                                              const SizedBox(width: 8),
                                              userInfo.userStatus == 'Admin'
                                                  ? TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return EditUserProfileWindow(
                                                              userName:
                                                                  doc['name'],
                                                              userEmail:
                                                                  doc['email'],
                                                              userStatus:
                                                                  doc['status'],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Iconsax.edit,
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              doc['profilePhoto']
                                                      .toString()
                                                      .isEmpty
                                                  ? const Icon(
                                                      BootstrapIcons
                                                          .person_circle,
                                                      size: 90,
                                                      color: Color.fromARGB(
                                                          255, 51, 0, 67),
                                                    )
                                                  : CachedNetworkImage(
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  progress) =>
                                                              const CircularProgressIndicator(),

                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                        BootstrapIcons
                                                            .person_circle,
                                                        size: 90,
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                      ),
                                                      // fit: BoxFit.cover,
                                                      imageUrl:
                                                          doc['profilePhoto'],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 90,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              const SizedBox(width: 8),
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
                                                        doc['email'].toString(),
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
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      'Frequência: ${(doc['frequence'] * 100).toStringAsFixed(0)}%',
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      'UserLevel: ${doc['status'].toString()}',
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 51, 0, 67),
                                                        fontFamily: "Poppins",
                                                        fontSize: 14,
                                                      ),
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
                          ),
                        );
                        //const SizedBox(height: 10),
                      }),
                ),
              ),
      ),
    );
  }
}
