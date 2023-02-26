// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/loginPages/newUserPage.dart';
import 'package:mermas_digitais_app/models/loadingWindow.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  String userProfilePhoto = '';

  Future userInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userName = data['name'];
      userEmail = data['email'];

      //getProfilePhoto
      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${user.uid}/profilephoto.jpg');

      await profilephotoRef.getDownloadURL().then((value) {
        userProfilePhoto = value;
      });
      print(userName);
      print(userEmail);
    } catch (e) {
      return print('Banco de dados vazio');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo(),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
            elevation: 3,
            toolbarHeight: 70,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            title: const Text(
              'Perfil',
              style: TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: 'PaytoneOne',
                  //fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Card(
              //margin: const EdgeInsets.only(bottom: 520),
              color: const Color.fromARGB(255, 221, 199, 248),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userProfilePhoto != ''
                        ? CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(userProfilePhoto))
                        : const Icon(
                            Iconsax.personalcard,
                            size: 90,
                            color: Color.fromARGB(255, 51, 0, 67),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 240,
                          child: Text(
                            maxLines: 1,
                            //textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            userName,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 51, 0, 67),
                              fontFamily: "PaytoneOne",
                              fontSize: 20,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 240,
                          child: Text(
                            maxLines: 1,
                            //textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            userEmail,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 51, 0, 67),
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWindow();
                                });
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.of(context).pop();
                              FirebaseAuth.instance.signOut();
                            });

                            // ignore: use_build_context_synchronously
                          },
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Iconsax.logout,
                                size: 25,
                                color: Color.fromARGB(255, 51, 0, 67),
                                fill: 1,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Sair',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWindow();
                                });
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewUserPage(),
                              ));
                            });

                            // ignore: use_build_context_synchronously
                          },
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Iconsax.document_upload,
                                size: 25,
                                color: Color.fromARGB(255, 51, 0, 67),
                                fill: 1,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'UpdateUser',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
