import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'get_user_info.dart';

class FrequenceOptions {
  GetUserInfo userInfo = GetUserInfo();
  String startDate = DateTime.now().toString();
  final user = FirebaseAuth.instance;
  final String frequencetUID = '';
  late int totalClasses;

  Future getTotalClassesInfo() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('frequences');
      var querySnap = await docRef.get();

      var queryDocumentSnapshot = querySnap.docs;
      var data = queryDocumentSnapshot.length;

      totalClasses = data - 1;
    } catch (e) {
      return print('Banco de dados vazio!');
    }
  }

  Future editTotalFrequenceDB() async {
    await getTotalClassesInfo().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('frequences')
          .doc('totalClasses')
          .update({
        'totalClasses': totalClasses++,
      });
    });
  }

  Future createFrequenceDB(title, frequenceClass, studentUID) async {
    var frequenceUID = const Uuid().v1();
    await getTotalClassesInfo().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('frequences')
          .doc(frequenceUID)
          .set({
        'frequenceTitle': title,
        'frequenceClass': frequenceClass,
        'frequenceUID': frequenceUID,
        'frequenceFlag': 'open',
        'frequenceStartDate': startDate,
        'frequenceEndDate': startDate =
            DateTime.now().add(const Duration(days: 5)).toString(),
        'autor':
            'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
      }).whenComplete(() async {
//create list of missing students
        await FirebaseFirestore.instance
            .collection('frequences')
            .doc(frequenceUID)
            .collection('Students')
            .doc('missingStudents')
            .set({
          'studentUID': studentUID,
          'frequenceUID': frequenceUID,
        });
      });

      //Add +1 on number of total classes
      editTotalFrequenceDB();
    });
  }

  Future editFrequenceDB(
      title, frequenceClass, frequenceUID, frequenceFlag) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .update({
      'frequenceTitle': title,
      'frequenceClass': frequenceClass,
      'frequenceFlag': frequenceFlag,
      'frequenceStartDate': startDate,
      'frequenceEndDate': startDate =
          DateTime.now().add(const Duration(days: 5)).toString(),
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
