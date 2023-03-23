// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/profileUserWindows/profile_user_windows.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/showToastMessage.dart';
import 'package:mermas_digitais_app/src/models/profileUserWindows/students_list_window/students_list_window.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  GetUserInfo userInfo = GetUserInfo();
  Duration duration = const Duration(seconds: 3);

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
                      padding: const EdgeInsets.all(15.0),
                      child: Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userInfo.userProfilePhoto == ""
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/logo_roxa.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              134, 221, 199, 248),
                                          shape: const CircleBorder(
                                              side: BorderSide.none),
                                        ),
                                        onPressed: () {
                                          uploadImage();
                                        },
                                        child:
                                            const Icon(BootstrapIcons.camera),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    progressIndicatorBuilder: (context, url,
                                            progress) =>
                                        const SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CircularProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 221, 199, 248),
                                            )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      BootstrapIcons.person_circle,
                                      size: 100,
                                      color: Color.fromARGB(255, 51, 0, 67),
                                    ),
                                    imageUrl: userInfo.userProfilePhoto,
                                    imageBuilder: (context, imageProvider) =>
                                        SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Container(
                                          width: 180,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        215, 221, 199, 248),
                                                shape: const CircleBorder(
                                                    side: BorderSide.none),
                                              ),
                                              onPressed: () {
                                                uploadImage();
                                              },
                                              child: const Icon(
                                                  BootstrapIcons.camera,
                                                  size: 40),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
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
                                  FittedBox(
                                    fit: BoxFit.contain,
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
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const ConfirmSignOut();
                                            },
                                          );
                                        },
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              BootstrapIcons.escape,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fill: 1,
                                            ),
                                            SizedBox(width: 2),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Sair',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 51, 0, 67),
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const ChangePassword();
                                            },
                                          );
                                        },
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Iconsax.refresh,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 51, 0, 67),
                                              fill: 1,
                                            ),
                                            SizedBox(width: 2),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Alterar senha',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 51, 0, 67),
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                  size: 26,
                ),
              )
            : null,
      ),
    );
  }

  void uploadImage() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const LoadingWindow();
        },
      );
      final profilePhoto = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50)
          .whenComplete(() => null);

      if (profilePhoto != null && userInfo.userProfilePhoto != '') {
        await FirebaseStorage.instance
            .ref()
            .child('users/${userInfo.user.uid}/profilePhoto')
            .delete();
      } else if (profilePhoto == null) {
        showToastMessage(message: 'Você não selecionou nenhuma foto.');
      } else {
        showToastMessage(message: 'Error ao fazer o upload da foto.');
      }

      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${userInfo.user.uid}/profilePhoto');

      await profilephotoRef.putFile(File(profilePhoto!.path));
      profilephotoRef.getDownloadURL().then((value) {
        setState(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(userInfo.user.uid)
              .update({
            'profilePhoto': value,
          }).whenComplete(() {
            Navigator.of(context).pop();
          });
          //userInfo.userProfilePhoto = value;
          showToastMessage(message: 'Você alterou sua foto de perfil!');
        });
      });
    } catch (e) {
      Navigator.of(context).pop();
      print('Erro ao fazer upload de foto: $e');
    }
  }
}
