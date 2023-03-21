// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'get_user_info.dart';

class PostOptions {
  GetUserInfo userInfo = GetUserInfo();

  String dateTime = DateTime.now().toString();
  bool isSwitched = false;
  final user = FirebaseAuth.instance;
  final String postUID = '';

  Future createPostDB(title, content, link) async {
    await FirebaseFirestore.instance.collection('posts').doc(dateTime).set({
      'postTitle': title,
      'postContent': content,
      'postLink': link,
      'postUID': dateTime,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future editPostDB(title, content, link, postUID) async {
    await FirebaseFirestore.instance.collection('posts').doc(postUID).update({
      'postTitle': title,
      'postContent': content,
      'postLink': link,
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future deletePostDB(String postUID) async {
    await FirebaseFirestore.instance.collection('posts').doc(postUID).delete();
  }
}
