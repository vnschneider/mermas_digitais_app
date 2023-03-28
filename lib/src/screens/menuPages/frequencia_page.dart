import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mermas_digitais_app/src/functions/frequence_functions.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/app_bar/app_bar.dart';
import 'package:mermas_digitais_app/src/models/frequence_windows/list_of_frequences.dart';
import 'package:mermas_digitais_app/src/models/frequence_windows/new_frequence_AlerDialog.dart';
import 'package:mermas_digitais_app/src/models/loading_window/loading_window.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../utils/showToastMessage.dart';

class FrequenciaPage extends StatefulWidget {
  const FrequenciaPage({super.key});

  @override
  State<FrequenciaPage> createState() => _FrequenciaPageState();
}

class _FrequenciaPageState extends State<FrequenciaPage> {
  final isDialOpen = ValueNotifier(false);
  GetUserInfo userInfo = GetUserInfo();
  double totalClasses = 0;
  double userFrequence = 0;
  FrequenceOptions frequenceOptions = FrequenceOptions();

  getFrequence(userAbsence, userUID) {
    //userInfo.getTotalClasses();
    userFrequence =
        ((userInfo.totalClasses - userAbsence) / userInfo.totalClasses);
    print('Frequencia do usuário!!!!!!:   $userFrequence');

    frequenceOptions.updateFrequenceUser(userUID, userFrequence);
    return userFrequence;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => WillPopScope(
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
            child: CustomAppBar(text: 'Frequência'),
          ),
          body: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: userInfo.userName == ''
                      ? const Center(child: LoadingWindow())
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
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
                                          BootstrapIcons.person_circle,
                                          size: 140,
                                          color: Color.fromARGB(255, 51, 0, 67),
                                        )
                                      : CachedNetworkImage(
                                          progressIndicatorBuilder: (context,
                                                  url, progress) =>
                                              const SizedBox(
                                                  height: 140,
                                                  width: 140,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromARGB(
                                                        255, 221, 199, 248),
                                                  )),

                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            BootstrapIcons.person_circle,
                                            size: 140,
                                            color:
                                                Color.fromARGB(255, 51, 0, 67),
                                          ),
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
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(height: 10),
                                  Text(
                                    userInfo.userName,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 51, 0, 67),
                                      fontFamily: "Poppins",
                                      fontSize: 20,
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
                                    percent: getFrequence(userInfo.userAbsence,
                                        userInfo.user.uid), //_userFrequence,
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
                                    /*   style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor: MaterialStateProperty.all(
                                            const Color.fromARGB(255, 51, 0, 67))),*/
                                    onPressed: () {
                                      showToastMessage(
                                          message:
                                              'Em breve você poderá acessar esta função');
                                    },
                                    child: const Text(
                                      '   Detalhes   ',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 51, 0, 67),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          floatingActionButton: userInfo.userLevel == 'Admin'
              ? SpeedDial(
                  heroTag: 'frequenceTag',
                  tooltip: 'Menu de frequência',
                  openCloseDial: isDialOpen,
                  curve: Curves.elasticInOut,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.2,
                  buttonSize: const Size(58, 58),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  icon: BootstrapIcons.clipboard,
                  activeIcon: BootstrapIcons.x,
                  children: [
                    SpeedDialChild(
                      child: const Icon(
                        BootstrapIcons.clipboard_pulse,
                        color: Color.fromARGB(255, 221, 199, 248),
                      ),
                      backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                      labelBackgroundColor:
                          const Color.fromARGB(255, 221, 199, 248),
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 51, 0, 67),
                          fontFamily: 'Poppins'),
                      label: 'Frequências registradas',
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return const FrequenceList();
                        },
                      ),
                    ),
                    SpeedDialChild(
                      child: const Icon(
                        BootstrapIcons.clipboard_plus,
                        color: Color.fromARGB(255, 221, 199, 248),
                      ),
                      backgroundColor: const Color.fromARGB(255, 51, 0, 67),
                      labelBackgroundColor:
                          const Color.fromARGB(255, 221, 199, 248),
                      labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 51, 0, 67),
                          fontFamily: 'Poppins'),
                      label: 'Nova frequência',
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return const NewFrequenceAlertDialog();
                        },
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
