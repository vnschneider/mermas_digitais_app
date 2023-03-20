import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/change_assword_window/change_assword_window.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/snack_bar/snack_bar.dart';
import 'package:mermas_digitais_app/src/models/students_list_window/students_list_window.dart';

import '../../models/app_bar/app_bar.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  GetUserInfo userInfo = GetUserInfo();
  Duration duration = const Duration(seconds: 3);

  String profilePhoto() {
    if (userInfo.userProfilePhoto == "") {
      return "https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg";
    } else {
      return userInfo.userProfilePhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: CustomAppBar(text: 'Perfil'),
        ),
        body: SafeArea(
          child: userInfo.userName == ''
              ? const LoadingWindow()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    //margin: const EdgeInsets.only(bottom: 520),
                    color: const Color.fromARGB(255, 221, 199, 248),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: uploadImage,
                            child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(profilePhoto())),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 215,
                                child: Text(
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  userInfo.userName,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "PaytoneOne",
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 215,
                                child: Text(
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  userInfo.userEmail,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const LoadingWindow();
                                        },
                                      );
                                      await FirebaseAuth.instance
                                          .signOut()
                                          .then((value) =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  'login',
                                                  ModalRoute.withName(
                                                      '/login')));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          BootstrapIcons.escape,
                                          size: 22,
                                          color: Color.fromARGB(255, 51, 0, 67),
                                          fill: 1,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Sair',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ChangePassword();
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Iconsax.refresh,
                                          size: 22,
                                          color: Color.fromARGB(255, 51, 0, 67),
                                          fill: 1,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Alterar senha',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  print(userInfo.userProfilePhoto);
                                },
                                child: const Text(
                                  "Aperta aqui",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
                                    fontFamily: "PaytoneOne",
                                    fontSize: 14,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        floatingActionButton: userInfo.userStatus == 'Admin'
            ? FloatingActionButton(
                tooltip: 'Lista de usuários',
                elevation: 2,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const StudentsList();
                    },
                  );
                },
                child: const Icon(
                  BootstrapIcons.person_gear,
                  size: 38,
                ),
              )
            : null,
      ),
    );
  }

  void uploadImage() async {
    final user = FirebaseAuth.instance;
    try {
      final profilePhoto = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);

      await FirebaseStorage.instance
          .ref()
          .child('users/${userInfo.user.uid}/profilePhoto.jpg')
          .delete();
      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${userInfo.user.uid}/profilePhoto.jpg');

      await profilephotoRef.putFile(File(profilePhoto!.path));
      profilephotoRef.getDownloadURL().then((value) {
        setState(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.currentUser!.uid)
              .update({
            'profilePhoto': value,
          });
          userInfo.userProfilePhoto = value;
        });
      });
    } catch (e) {
      scaffoldMessenger(
        context: context,
        duration: duration,
        text: "Erro em Upload Img: $e",
      );
    }
  }
}
