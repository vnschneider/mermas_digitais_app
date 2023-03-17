// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mermas_digitais_app/core/exports/login_page_exports.dart';
import '../../functions/get_user_info.dart';

class NewPostWindow extends StatefulWidget {
  const NewPostWindow({super.key});

  @override
  State<NewPostWindow> createState() => _NewPostWindowState();
}

class _NewPostWindowState extends State<NewPostWindow> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  final user = FirebaseAuth.instance;
  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  GetUserInfo userInfo = GetUserInfo();

  Future createPostDB(String title, content, link) async {
    await FirebaseFirestore.instance.collection('posts').doc(dateTime).set({
      'postTitle': title,
      'postContent': content,
      'postLink': link,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userInfo.getUserInfo(),
      builder: (context, snapshot) => AlertDialog(
        title: const Text(
          "Novo comunicado",
          style: TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 20,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Adicionar link',
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 0, 67),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  inactiveThumbColor: const Color.fromARGB(255, 221, 199, 248),
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            CustomTextField(
              expanded: false,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _titleController,
              hintText: 'Título',
            ),
            CustomTextField(
              expanded: true,
              keyboardType: TextInputType.text,
              enabled: true,
              useController: true,
              controller: _contentController,
              hintText: 'Conteúdo',
            ),
            isSwitched == false
                ? const SizedBox()
                : CustomTextField(
                    expanded: true,
                    keyboardType: TextInputType.url,
                    enabled: true,
                    useController: true,
                    controller: _linkController,
                    hintText: 'Link',
                  )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty &&
                      isSwitched == false ||
                  _linkController.text.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const LoadingWindow();
                    });
                createPostDB(_titleController.text, _contentController.text,
                        _linkController.text)
                    .whenComplete(() => Navigator.of(context).pop());
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Color.fromARGB(255, 221, 199, 248),
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
                        "Tenha certeza de que preencheu os campos corretamente.",
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
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
