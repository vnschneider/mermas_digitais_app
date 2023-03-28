// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mermas_digitais_app/src/functions/frequence_functions.dart';

class GetUserInfo {
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  double userFrequence = 0;
  int userAbsence = 0;
  String userProfilePhoto = '';
  String userLevel = '';
  double totalClasses = 0;

  Future getTotalClassesInfo() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('frequences');
      var querySnap = await docRef.get();

      var queryDocumentSnapshot = querySnap.docs;
      var data = queryDocumentSnapshot.length;

      return totalClasses = (data - 1).toDouble();
    } catch (e) {
      return print('Banco de dados vazio!');
    }
  }

  Future getUserInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userName = data['name'];
      userEmail = data['email'];
      userAbsence = data['userAbsence'];
      userFrequence = data['frequence'];
      userLevel = data['userLevel'];
      userProfilePhoto = data['profilePhoto'];

      final docRefClasses = FirebaseFirestore.instance.collection('frequences');
      var querySnap = await docRefClasses.get();

      var queryDocumentSnapshot = querySnap.docs;
      var data2 = queryDocumentSnapshot.length;
      totalClasses = (data2 - 1).toDouble();
    } catch (e) {
      return print('Banco de dados vazio!');
    }
  }
}
