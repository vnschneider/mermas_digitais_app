import 'package:mermas_digitais_app/core/exports/new_user_exports.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var userProfilePhoto = '';
  String userUID = '';
  String userEmail = '';
  bool _showPassword = true;

  Future updateUser() async {
    try {
      await user.updatePassword(_passwordController.text.trim());
      addUserDetails(_nameController.text.trim());
    } catch (e) {
      print('Algo deu errado!');
    }
  }

  Future addUserDetails(String name) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': name,
      'email': user.email,
      'frequence': 1.0,
      'status': 'Aluna',
    });
  }

  Future userInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userUID = docRef.toString();
      userEmail = data['email'];

      print(userUID);
      print(userEmail);
      print(userProfilePhoto);
    } catch (e) {
      return print('Banco de dados vazio');
    }
  }

  void uploadImage() async {
    try {
      final profilePhoto = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);

      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${user.uid}/profilephoto.jpg');

      await profilephotoRef.putFile(File(profilePhoto!.path));
      profilephotoRef.getDownloadURL().then((value) {
        setState(() {
          userProfilePhoto = value;
        });
        print(value);
      });
    } catch (e) {
      print("O processo falhou: ");
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void showPassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _nameController.dispose();
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
                    uploadImage();
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 0, 67),
                      border: Border.all(
                          color: const Color.fromARGB(200, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Seu UID: ${user.uid.toString()}',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248),
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 0, 67),
                      border: Border.all(
                          color: const Color.fromARGB(200, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        enabled: false,
                        //controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email: ${user.email}',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //Name TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 51, 0, 67),
                      border: Border.all(
                          color: const Color.fromARGB(200, 221, 199, 248)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nome',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 221, 199, 248)),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                      if (_nameController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const LoadingWindow();
                            });
                        updateUser()
                            .whenComplete(() => Navigator.of(context).pop());
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
