// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ClassOptions {
  final user = FirebaseAuth.instance;
  String className = '';
  var newFormat = DateFormat('d, MMM.');

  Future createClassDB(String title, content) async {
    await FirebaseFirestore.instance.collection('classes').doc(title).set({
      'classTitle': title,
      'classContent': content,
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

  Future getClassInfo(String classUID) async {
    var classInfo = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classUID)
        .get();

    final data = classInfo.data() as Map<String, dynamic>;

    className = data['classTitle'];

    return classInfo;
  }

  Future createClassContentDB(String classUID, String contentName,
      String contentDescription, String contentLink, String autor) async {
    await FirebaseFirestore.instance
        .collection('classes')
        .doc(classUID)
        .collection('classContent')
        .doc(contentName)
        .set({
      'contentName': contentName,
      'contentDescription': contentDescription,
      'classUID': classUID,
      'displayAutor': autor,
      'createDate': DateTime.now(),
      'displayDate': newFormat.format(DateTime.now()),
      'link': contentLink,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future deleteClassContentDB(String classUID, String contentName) async {
    await FirebaseFirestore.instance
        .collection('classes')
        .doc(classUID)
        .collection('classContent')
        .doc(contentName)
        .delete();
  }
}
