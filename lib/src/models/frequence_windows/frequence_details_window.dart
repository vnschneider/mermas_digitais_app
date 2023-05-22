import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../functions/get_user_info.dart';
import '../loading_window/loading_window.dart';

class FrequenceDetailsWindows extends StatefulWidget {
  const FrequenceDetailsWindows({super.key, required this.userUID});
  final String userUID;

  @override
  State<FrequenceDetailsWindows> createState() =>
      _FrequenceDetailsWindowsState();
}

class _FrequenceDetailsWindowsState extends State<FrequenceDetailsWindows> {
  GetUserInfo userInfo = GetUserInfo();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Detalhes'),
      content: FutureBuilder(
        future: userInfo.getUserInfo(),
        builder: (context, snapshot) => StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where(FieldPath.fromString('name'), isEqualTo: userInfo.userName)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
              !snapshot.hasData
                  ? const LoadingWindow()
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot doc = snapshot.data!.docs[index];
                        return Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Nome da aluna ${doc['name']}'),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
