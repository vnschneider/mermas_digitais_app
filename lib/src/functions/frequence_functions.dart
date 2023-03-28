import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'get_user_info.dart';

class FrequenceOptions {
  GetUserInfo userInfo = GetUserInfo();
  var date = DateTime.now();
  var newFormat = DateFormat('d/MM,').add_H();
  late String startDate = '${newFormat.format(date)}h';

  final user = FirebaseAuth.instance;
  final String frequenceUID = '';
  late int totalClasses;
  late int userAbsence = 0;

  Future getUserName(userUID) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userUID);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;

    return data['name'].toString();
  }

  Future getMissinngClassesUser(userUID) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(userUID);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>;

      return userAbsence = data['userAbsence'].toInt();
    } catch (e) {
      print('Erro ao adicionar frequencia ao usuário: $e');
    }
  }

  Future removeMissinngClass(userUID) async {
    final docRef = FirebaseFirestore.instance.collection('users').doc(userUID);
    final doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    int userAbsence;

    userAbsence = data['userAbsence'].toInt();

    await FirebaseFirestore.instance.collection('users').doc(userUID).update({
      'userAbsence': userAbsence--,
    });
  }

  getEndDate(startDate) {
    startDate = DateTime.now().add(const Duration(days: 5));
    String endDate = '${newFormat.format(startDate)}h'.toString();

    return endDate;
  }

  changeFrequenceFlag(frequenceUID, flag) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .update({
      'frequenceFlag': flag,
    });
  }

  Future getTotalClassesInfo() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('frequences');
      var querySnap = await docRef.get();

      var queryDocumentSnapshot = querySnap.docs;
      var data = queryDocumentSnapshot.length;

      return totalClasses = data - 1;
    } catch (e) {
      return print('Banco de dados vazio!');
    }
  }

  Future updateFrequenceUser(userUID, double userFrequence) async {
    await FirebaseFirestore.instance.collection('users').doc(userUID).update({
      'frequence': userFrequence,
    });
  }

  Future addTotalFrequenceDB() async {
    await getTotalClassesInfo().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('frequences')
          .doc('totalClasses')
          .update({
        'totalClasses': totalClasses++,
      });
    });
  }

  Future removeTotalFrequenceDB() async {
    await getTotalClassesInfo().whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('frequences')
          .doc('totalClasses')
          .update({'totalClasses': totalClasses--});
    });
  }

  Future createFrequenceDB(
      title, frequenceClass, userUID, frequencePassUID) async {
    var frequenceUID = const Uuid().v1();
    String autorName = await getUserName(userUID);
    userUID = userInfo.user.uid;
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
        'frequenceEndDateDisplay': getEndDate(startDate),
        'autor': userUID,
        'autorName': autorName,
      });
      //Create list of missign students
      //createMissignStudent(frequenceUID);
      //Add +1 on number of total classes
      addTotalFrequenceDB();
    });

    return frequencePassUID = frequenceUID;
  }

  Future addMissignStudent(studentUID, frequenceUID) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .collection('Students')
        .doc(studentUID)
        .set({
      'studentUID': studentUID,
      'frequenceUID': frequenceUID,
    });

    await getMissinngClassesUser(studentUID)
        .then((value) => userAbsence = value.toInt())
        .whenComplete(() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(studentUID)
          .update({'userAbsence': userAbsence + 1});
    });
  }

  Future removeMissignStudent(studentUID, frequenceUID) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .collection('Students')
        .doc(studentUID)
        .delete();
    await getMissinngClassesUser(studentUID)
        .then((value) => userAbsence = value.toInt())
        .whenComplete(() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(studentUID)
          .update({'userAbsence': userAbsence - 1});
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
      'frequenceEndDateDisplay': getEndDate(startDate),
      'autor':
          'uid: ${user.currentUser!.uid} email: ${user.currentUser!.email}',
    });
  }

  Future deleteFrequenceDB(String frequenceUID) async {
    await FirebaseFirestore.instance
        .collection('frequences')
        .doc(frequenceUID)
        .collection('Students')
        .doc()
        .delete()
        .whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('frequences')
          .doc(frequenceUID)
          .delete();
      removeTotalFrequenceDB();
    });
  }
}
