import 'package:mermas_digitais_app/core/exports/perfil_exports.dart';
import 'package:mermas_digitais_app/src/functions/get_user_info.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Card(
              //margin: const EdgeInsets.only(bottom: 520),
              color: const Color.fromARGB(255, 221, 199, 248),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userInfo.userProfilePhoto != ''
                        ? CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                NetworkImage(userInfo.userProfilePhoto))
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
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return const LoadingWindow();
                              },
                            );
                            await FirebaseAuth.instance.signOut().then(
                                (value) =>
                                    Navigator.pushNamed(context, 'login'));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Iconsax.logout,
                                size: 25,
                                color: Color.fromARGB(255, 51, 0, 67),
                                fill: 1,
                              ),
                              SizedBox(width: 5),
                              Text(
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
                              },
                            );
                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const NewUserPage(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Iconsax.document_upload,
                                size: 25,
                                color: Color.fromARGB(255, 51, 0, 67),
                                fill: 1,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Atualizar Usuário',
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
