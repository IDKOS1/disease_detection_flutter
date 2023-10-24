import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';


class WillPopController {
  DateTime currentDateTime = DateTime.now();
  // 뒤로가기 종료
  Future<bool> handleWillPopScopeAction() async {
    DateTime now = DateTime.now();

    if (now.difference(currentDateTime) > const Duration(milliseconds: 1000)) {
      currentDateTime = now;
      Fluttertoast.showToast(
        msg: "한번 더 누르면 앱이 종료됩니다",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      exit(0);
    }
    return false;
  }
}
