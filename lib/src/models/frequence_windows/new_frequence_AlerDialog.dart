import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mermas_digitais_app/src/functions/frequence_functions.dart';
import 'package:mermas_digitais_app/src/models/frequence_windows/new_frequence_window.dart';

import '../../functions/get_user_info.dart';
import '../loading_window/loading_window.dart';
import '../showToastMessage.dart';

class NewFrequenceAlertDialog extends StatefulWidget {
  const NewFrequenceAlertDialog({super.key});

  @override
  State<NewFrequenceAlertDialog> createState() =>
      _NewFrequenceAlertDialogState();
}

class _NewFrequenceAlertDialogState extends State<NewFrequenceAlertDialog> {
  GetUserInfo userInfo = GetUserInfo();
  FrequenceOptions frequenceOptions = FrequenceOptions();
  final _titleController = TextEditingController();
  final _classController = TextEditingController();
  final List<String> items = [];
  String frequenceUID = '';
  String? value;

  Future loadOficinasList() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('class');
      var querySnap = await docRef.get();
      if (items.isEmpty) {
        for (var queryDocumentSnapshot in querySnap.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();

          items.add(data['classTitle']);
        }
      }
    } catch (e) {
      showToastMessage(
          message: 'Não foi possível carregar a lista de oficinas.');
    }
  }

  @override
  void initState() {
    loadOficinasList();
    super.initState();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            color: Color.fromARGB(255, 221, 199, 248),
            fontFamily: "Poppins",
            // fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );

  @override
  void dispose() {
    _titleController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova frequencia'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //TEXTFIELD
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 0, 67),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Título da aula',
                    hintStyle: TextStyle(
                        //fontSize: 15,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 221, 199, 248)),
                  ),
                  controller: _titleController,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          ///DROP DOWN MENU
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 51, 0, 67),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                alignment: Alignment.center,
                icon: const Icon(BootstrapIcons.caret_down_fill),
                isExpanded: true,
                iconDisabledColor: const Color.fromARGB(255, 221, 199, 248),
                iconEnabledColor: const Color.fromARGB(255, 221, 199, 248),
                dropdownColor: const Color.fromARGB(255, 51, 0, 67),
                value: value,
                items: items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                value.toString().isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const LoadingWindow();
                  });

              frequenceOptions
                  .createFrequenceDB(
                      _titleController.text, value, userInfo.user.uid)
                  .whenComplete(() {
                showToastMessage(message: 'Aula adicionada!');
                Navigator.of(context).pushNamed('addStudents');

                frequenceOptions.getFrequenceUID(frequenceUID);
              });
              //Navigator.of(context).pop();
            } else {
              showToastMessage(
                  message:
                      'Algo deu errado! Tenha certeza de que preencheu os campos corretamente.');
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    );
  }
}
