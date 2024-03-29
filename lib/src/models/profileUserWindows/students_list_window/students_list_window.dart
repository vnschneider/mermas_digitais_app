import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/profileUserWindows/students_list_window/edit_user_profile_window.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/utils/showToastMessage.dart';

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
  String searchData = '';
  final List<String> _suggestionsList = [];

  Future loadSearchValue() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('users');
      var querySnap = await docRef.get();
      if (_suggestionsList.isEmpty) {
        for (var queryDocumentSnapshot in querySnap.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();

          _suggestionsList.add(data['name']);
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
                .collection('users')
                .where(FieldPath.fromString('name'), isEqualTo: searchValue)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('users')
                .orderBy(FieldPath.fromString('name'))
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
              : SafeArea(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                            const SizedBox(width: 8),
                                            userInfo.userLevel == 'Admin'
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
                                                            userLevel: doc[
                                                                'userLevel'],
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
                                                    .isNotEmpty
                                                ? CachedNetworkImage(
                                                    memCacheHeight: 2000,
                                                    memCacheWidth: 2000,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            const SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          221,
                                                                          199,
                                                                          248),
                                                                )),

                                                    errorWidget:
                                                        (context, url, error) =>
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
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            const SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          221,
                                                                          199,
                                                                          248),
                                                                )),

                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      BootstrapIcons
                                                          .person_circle,
                                                      size: 90,
                                                      color: Color.fromARGB(
                                                          255, 51, 0, 67),
                                                    ),
                                                    // fit: BoxFit.cover,
                                                    imageUrl:
                                                        'https://firebasestorage.googleapis.com/v0/b/mermas-digitais-2023.appspot.com/o/fundo-roxo-v.png?alt=media&token=32460753-3c18-46fc-be25-d682f3af5ad6',

                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 90,
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(width: 8),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    textAlign: TextAlign.start,
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
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                      }),
                ),
        ),
      ),
    );
  }
}
