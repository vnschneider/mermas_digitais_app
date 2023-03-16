import 'package:mermas_digitais_app/core/exports/login_page_exports.dart';
import 'package:mermas_digitais_app/core/exports/new_user_exports.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final user = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var userProfilePhoto = '';
  String userUID = '';
  String userEmail = '';
  bool _showPassword = true;

  Future newUser() async {
    try {
      await user.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      print(e);
    }
  }

  Future createUserDB(String name) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser!.uid)
        .set({
      'name': name,
      'email': user.currentUser!.email,
      'frequence': 1.0,
      'status': 'Aluna',
    });
    print(user.currentUser!.uid);
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const OlaMerma(
                  title: 'Conclua seu cadastro',
                  usetext: false,
                  text: '',
                ),

                //ProfilePhoto Container

                GestureDetector(
                  onTap: () {
                    // uploadImage();
                  },
                  child: userProfilePhoto != ''
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(userProfilePhoto))
                      : const CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Iconsax.personalcard,
                            size: 120,
                            color: Color.fromARGB(255, 221, 199, 248),
                          ),
                        ),
                ),
                const SizedBox(height: 30),
                //UID TextField
                CustomTextField(
                  controller: _nameController,
                  hintText: "Nome",
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
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
                              color: const Color.fromARGB(200, 221, 199, 248),
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
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWindow();
                            });
                        newUser().whenComplete(() {
                          createUserDB(_nameController.text.trim());
                          Navigator.pushNamed(context, "login");
                        });
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 51, 0, 67),
                                ),
                              ),
                              content: Text(
                                "Tenha certeza de que preencheu os campos corretamente!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                            color: const Color.fromARGB(255, 221, 199, 248)),
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
    );
  }
}
