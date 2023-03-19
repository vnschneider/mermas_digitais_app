import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:mermas_digitais_app/core/exports/frequencia_exports.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';
import 'package:mermas_digitais_app/src/models/newFrequence_window/newFrequence_window.dart';

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
        appBar: AppBar(
            elevation: 3,
            toolbarHeight: 70,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            title: const Text(
              'Frequência',
              style: TextStyle(
                  color: Color.fromARGB(255, 221, 199, 248),
                  fontFamily: 'PaytoneOne',
                  //fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
        body: SafeArea(
          child: Center(
            child: userInfo.userName == ''
                ? const LoadingWindow()
                : Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: const Color.fromARGB(255, 221, 199, 248),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
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
                          userInfo.userProfilePhoto != ''
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage(userInfo.userProfilePhoto))
                              : const Icon(
                                  Iconsax.personalcard,
                                  size: 120,
                                  color: Color.fromARGB(255, 51, 0, 67),
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
                            percent: userInfo.userFrequence, //_userFrequence,
                            progressColor: const Color.fromARGB(255, 51, 0, 67),
                            backgroundColor:
                                const Color.fromARGB(255, 221, 199, 248),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 330,
                                child: Text(
                                  'Você possui ${(userInfo.userFrequence * 100).toStringAsFixed(0)}% de presença nas aulas.',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.justify,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 51, 0, 67),
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
                                        color: Color.fromARGB(255, 51, 0, 67),
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
                                          color: Color.fromARGB(255, 51, 0, 67),
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
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 51, 0, 67))),
                            onPressed: () {},
                            child: const Text(
                              '   Detalhes   ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 221, 199, 248),
                              ),
                            ),
                          ),
                        ],
                      ),
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
