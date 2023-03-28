// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClassOptions {
  final user = FirebaseAuth.instance;

  Future createClassDB(String title, content, link) async {
    await FirebaseFirestore.instance.collection('classes').doc(title).set({
      'classTitle': title,
      'classContent': content,
      'classLink': link,
      'classUID': title,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future deleteClassDB(String classUID) async {
    await FirebaseFirestore.instance
        .collection('classes')
        .doc(classUID)
        .delete();
  }
}
