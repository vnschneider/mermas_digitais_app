// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetUserInfo {
  final user = FirebaseAuth.instance.currentUser!;
  String userEmail = '';
  String userName = '';
  double userFrequence = 0;
  String userProfilePhoto = '';

  Future getUserInfo() async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection("users").doc(user.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      userName = data['name'];
      userEmail = data['email'];
      userFrequence = data['frequence'];

      //getProfilePhoto
      final profilephotoRef = FirebaseStorage.instance
          .ref()
          .child('users/${user.uid}/profilephoto.jpg');

      await profilephotoRef.getDownloadURL().then((value) {
        userProfilePhoto = value;
      });
    } catch (e) {
      return print('Banco de dados vazio!');
    }
  }
}
