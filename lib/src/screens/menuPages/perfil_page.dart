import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/change_assword_window/change_assword_window.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/students_list_window/students_list_window.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  GetUserInfo userInfo = GetUserInfo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
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
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: userInfo.userName == ''
                ? const LoadingWindow()
                : Card(
                    //margin: const EdgeInsets.only(bottom: 520),
                    color: const Color.fromARGB(255, 221, 199, 248),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  NetworkImage(userInfo.userProfilePhoto)),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 223,
                                child: Text(
                                  maxLines: 1,
                                  //textAlign: TextAlign.start,
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
                                width: 223,
                                child: Text(
                                  maxLines: 1,
                                  //textAlign: TextAlign.start,
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
                                          .then((value) => Navigator.pushNamed(
                                              context, 'login'));
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          BootstrapIcons.escape,
                                          size: 25,
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
                                              fontSize: 16,
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
                                      children: const [
                                        Icon(
                                          Iconsax.refresh,
                                          size: 25,
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
}
