import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool validateEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

void showAwesomeDialog(BuildContext context, String message, DialogType dialogType) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.scale,
    title: dialogType == DialogType.success ? 'Succès' : 'Erreur',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}