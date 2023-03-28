// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/alertDialogs/alertDialogs.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/snack_bar/snack_bar.dart';
import 'package:mermas_digitais_app/src/models/textFields/custom_text_field.dart';

import '../../utils/showToastMessage.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final user = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final WillPop = ValueNotifier(true);
  Duration duration = const Duration(seconds: 3);
  GetUserInfo userInfo = GetUserInfo();
  var userProfilePhoto = '';
  String userUID = '';
  String userEmail = '';
  bool _showPassword = true;
  // bool WillPop = false;

  Future newUser() async {
    try {
      await user.currentUser!.updatePassword(_passwordController.text);
    } catch (e) {
      scaffoldMessenger(
        context: context,
        duration: duration,
        text: "Erro em newUser: $e",
      );
    }
  }

  Future createUserDB(String name) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser!.uid)
        .update({
      'name': name,
      'email': user.currentUser!.email,
      'userAbsence': 0,
      'userUID': user.currentUser!.uid,
      'frequence': 1.0,
      'userLevel': 'Aluna',
      'profilePhoto': userInfo.userProfilePhoto,
    });
  }

  void uploadImage() async {
    try {
      final profilePhoto = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50)
          .whenComplete(() => null);

      if (profilePhoto != null && userInfo.userProfilePhoto != '') {
        await FirebaseStorage.instance
            .ref()
            .child('users/${userInfo.user.uid}/profilePhoto')
            .delete()
            .whenComplete(
                () => showToastMessage(message: 'Foto antiga deletada!'));
      } else if (profilePhoto == null) {
        showToastMessage(message: 'Você não selecionou nenhuma foto');
      }

      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${userInfo.user.uid}/profilePhoto');

      await profilephotoRef.putFile(File(profilePhoto!.path));
      profilephotoRef.getDownloadURL().then((value) {
        setState(() {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.currentUser!.uid)
              .set({
            'profilePhoto': value,
          });
          userInfo.userProfilePhoto = value;
        });
      });
    } catch (e) {
      showToastMessage(message: 'Erro: $e');
    }
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => WillPopScope(
        onWillPop: () async {
          if (WillPop.value == true) {
            showDialog(
              context: context,
              builder: (context) {
                return const ConfirmSignUpExit();
              },
            );
            return WillPop.value = true;
            //return true;
            //close speed dial
          } else {
            return WillPop.value = false;
            // return false;
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 51, 0, 67),
          body: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            shrinkWrap: true,
            reverse: true,
            padding:
                const EdgeInsets.only(top: 60, right: 20, left: 20, bottom: 20),
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Conclua seu cadastro',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color.fromARGB(255, 221, 199, 248),
                            fontFamily: 'PaytoneOne',
                            //fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 60),
                    //ProfilePhoto Container

                    userInfo.userProfilePhoto != ''
                        ? CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => const SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 221, 199, 248),
                                    )),
                            errorWidget: (context, url, error) => const Icon(
                              BootstrapIcons.person_circle,
                              size: 100,
                              color: Color.fromARGB(255, 51, 0, 67),
                            ),
                            imageUrl: userInfo.userProfilePhoto,
                            imageBuilder: (context, imageProvider) => Container(
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
                                    backgroundColor: const Color.fromARGB(
                                        255, 221, 199, 248),
                                    shape: const CircleBorder(
                                        side: BorderSide.none),
                                  ),
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  child: const Icon(
                                    BootstrapIcons.camera,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          )
                        //
                        : CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => const SizedBox(
                                    height: 180,
                                    width: 180,
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 221, 199, 248),
                                    )),
                            errorWidget: (context, url, error) => const Icon(
                              BootstrapIcons.person_circle,
                              size: 100,
                              color: Color.fromARGB(255, 51, 0, 67),
                            ),
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/mermas-digitais-2023.appspot.com/o/LogoMermasDigitaisRoxa.png?alt=media&token=e82b7363-96e8-4b74-b78d-37f9c81938d2',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        215, 221, 199, 248),
                                    shape: const CircleBorder(
                                        side: BorderSide.none),
                                  ),
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  child: const Icon(
                                    BootstrapIcons.camera,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    //UID TextField

                    CustomTextField(
                      expanded: false,
                      keyboardType: TextInputType.name,
                      useController: true,
                      enabled: true,
                      controller: _nameController,
                      hintText: 'Nome',
                    ),
                    CustomTextField(
                      expanded: false,
                      keyboardType: TextInputType.emailAddress,
                      useController: false,
                      enabled: false,
                      controller: _nameController,
                      hintText: user.currentUser!.email,
                    ),
                    //Password TextField
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 51, 0, 67),
                          border: Border.all(
                              color: const Color.fromARGB(255, 221, 199, 248)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _showPassword,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  showPassword();
                                },
                                child: Icon(
                                  _showPassword == true
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                  color:
                                      const Color.fromARGB(200, 221, 199, 248),
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: 'Senha',
                              hintStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 221, 199, 248)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    //Confirm Password TextField
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 51, 0, 67),
                          border: Border.all(
                              color: const Color.fromARGB(255, 221, 199, 248)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirmar senha',
                              hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 221, 199, 248)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    //RegisterButton
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: GestureDetector(
                        onTap: () {
                          if (_passwordController.text.length < 6) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const CustomAlertDialog(
                                    title: 'Ops...',
                                    content:
                                        'Sua senha deve conter no mínimo 6 caracteres.',
                                    asyncType: false,
                                    userActions: false,
                                  );
                                });
                          } else if (_nameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty &&
                              userInfo.userProfilePhoto.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const LoadingWindow();
                                });
                            newUser().whenComplete(() {
                              createUserDB(_nameController.text.trim());
                              user.currentUser!.reauthenticateWithCredential(
                                  EmailAuthProvider.credential(
                                      email: user.currentUser!.email.toString(),
                                      password: _passwordController.text));
                            }).whenComplete(() =>
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'auth', ModalRoute.withName('/')));
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 221, 199, 248),
                                  title: Text(
                                    "Algo deu errado!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 51, 0, 67),
                                    ),
                                  ),
                                  content: Text(
                                    "Tenha certeza de que preencheu os campos corretamente e adicionou uma foto de perfil.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 51, 0, 67),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 51, 0, 67),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 221, 199, 248)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 221, 199, 248),
                                  fontFamily: 'Poppins',
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
