import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

Stream collectionStream =
    FirebaseFirestore.instance.collection('users').snapshots();
Stream documentStream = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  String _title = ' ';
  final userFrequence = 0;

  final _userInfo = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      double userFrequence = documentSnapshot as double;
      print('O documento existe no database: $userFrequence');
    }
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('O documento existe no database: $_userInfo'),
      ),
    );
  }
}
