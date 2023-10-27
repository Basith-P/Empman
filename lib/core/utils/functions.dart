import 'package:emplman/core/global_keys.dart';
import 'package:flutter/material.dart' show SnackBar, Text;

void showSnackBar(String message) {
  final snackBar = SnackBar(content: Text(message));
  scaffoldMessengerKey.currentState!
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}
