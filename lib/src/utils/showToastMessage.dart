// ignore_for_file: file_names

import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

Future showToastMessage({required String message}) async {
  await Fluttertoast.cancel();

  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: const Color.fromARGB(255, 51, 0, 67),
    backgroundColor: const Color.fromARGB(255, 221, 199, 248),
    msg: message,
    fontSize: 14,
  );
}
