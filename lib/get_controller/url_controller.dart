import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class UrlController extends GetxController {
  static UrlController get to => Get.find();
  final url = Uri.parse('http://localhost:8000');

  Future<void> registerUser(String email, String password, String username, String birth, String gender, String number, String farm) async {
    final response = await http.post(
        url.resolve('/register/signup'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String> {
          'email': email,
          'password': password,
          'username': username,
          'birth': birth,
          'gender': gender,
          'number': number,
          'farm': farm
        })
    );
    print("응답:${response.statusCode}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입이 완료 되었습니다.');
      Get.back();
    } else {
      Fluttertoast.showToast(msg: '에러 발생.');
    }

  }
}

