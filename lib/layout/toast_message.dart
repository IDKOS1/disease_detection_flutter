import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastmsg(String text) {
  Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[700],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT);
}
