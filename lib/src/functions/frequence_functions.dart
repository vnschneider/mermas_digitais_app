// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'get_user_info.dart';

class FrequenceOptions {
  GetUserInfo userInfo = GetUserInfo();

  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  final user = FirebaseAuth.instance;
  final String frequencetUID = '';
  late int totalClasses;

  Future createTotalClassesDB() async {
    final docRef =
        FirebaseFirestore.instance.collection('frequences').doc('totalClasses');
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;

    totalClasses = data['totalClasses'];

    await FirebaseFirestore.instance
        .collection('frequences')
        .doc('totalClasses')
        .set({
      'totalClasses': totalClasses++,
    });
  }

  Future editTotalFrequenceDB() async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc('totalClasses')
        .update({
      'totalClasses': totalClasses++,
    });
  }

  Future createFrequenceDB(title, frequenceClass) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(dateTime)
        .set({
      'frequenceTitle': title,
      'frequenceClass': frequenceClass,
      'frequenceUID': dateTime,
      'frequenceFlag': 'open',
      'frequenceStartDate': dateTime,
      'frequenceEndDate': dateTime,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });

    editTotalFrequenceDB();
  }

  Future editFrequenceDB(title, frequenceClass, frequenceUID) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .update({
      'postTitle': title,
      'postContent': frequenceClass,
      'postDate': dateTime,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future deleteFrequenceDB(String frequenceUID) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .delete();
  }
}
