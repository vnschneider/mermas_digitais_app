import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:mermas_digitais_app/src/models/new_frequence_window/new_frequence_window.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../models/showToastMessage.dart';

class FrequenciaPage extends StatefulWidget {
  const FrequenciaPage({super.key});

  @override
  State<FrequenciaPage> createState() => _FrequenciaPageState();
}

class _FrequenciaPageState extends State<FrequenciaPage> {
  GetUserInfo userInfo = GetUserInfo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: CustomAppBar(text: 'Frequência'),
        ),
        body: SafeArea(
          child: Center(
            child: userInfo.userName == ''
                ? const LoadingWindow()
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListView(
                      children: [
                        Flexible(
                          child: Card(
                            color: const Color.fromARGB(255, 221, 199, 248),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Text(
                                        'Situação',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 51, 0, 67),
                                          fontFamily: "PaytoneOne",
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 60),
                                  userInfo.userProfilePhoto == ""
                                      ? const Icon(
                                          BootstrapIcons.person_add,
                                          size: 80,
                                        )
                                      : CachedNetworkImage(
                                          // fit: BoxFit.cover,
                                          imageUrl: userInfo.userProfilePhoto,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 140,
                                            height: 140,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(height: 10),
                                  Text(
                                    userInfo.userName,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 51, 0, 67),
                                      fontFamily: "Poppins",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  LinearPercentIndicator(
                                    barRadius: const Radius.circular(8),
                                    animation: true,
                                    animateFromLastPercent: true,
                                    animationDuration: 1000,
                                    lineHeight: 30,
                                    percent: userInfo
                                        .userFrequence, //_userFrequence,
                                    progressColor:
                                        const Color.fromARGB(255, 51, 0, 67),
                                    backgroundColor: const Color.fromARGB(
                                        255, 221, 199, 248),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 320,
                                        child: Text(
                                          'Você possui ${(userInfo.userFrequence * 100).toStringAsFixed(0)}% de presença nas aulas.',
                                          overflow: TextOverflow.clip,
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 51, 0, 67),
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      userInfo.userFrequence >= 0.25
                                          ? const Text(
                                              'Parabéns pelo seu empenho!',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 0, 67),
                                                fontFamily: "Poppins",
                                                fontSize: 15,
                                              ),
                                            )
                                          : const Expanded(
                                              child: Text(
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.clip,
                                                'Cuidado, você corre o risco de ser reprovada. :(',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 51, 0, 67),
                                                  fontFamily: "Poppins",
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(height: 100),
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 51, 0, 67))),
                                    onPressed: () {
                                      showToastMessage(
                                          message:
                                              'Em breve você poderá acessar esta função');
                                    },
                                    child: const Text(
                                      '   Detalhes   ',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 221, 199, 248),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        floatingActionButton: userInfo.userStatus == 'Admin'
            ? FloatingActionButton(
                tooltip: 'Nova frequência',
                elevation: 2,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const NewFrequenceWindow();
                    },
                  );
                },
                child: const Icon(
                  BootstrapIcons.clipboard_plus,
                  size: 38,
                ))
            : null,
      ),
    );
  }
}
