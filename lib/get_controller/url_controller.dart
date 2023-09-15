import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class UrlController extends GetxController {
  static UrlController get to => Get.find();
  final url = Uri.parse('http://10.0.2.2:8000');

  RxBool showSpinner = false.obs;

  Future<void> registerUser(String email, String password, String username, String birth, String gender, String number, String farm) async {
    print(url.resolve('/register/signup/'));
    try{
    final response = await http.post(
        url.resolve('/register/signup/'),
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
    ).timeout(const Duration(seconds: 20));

    print("응답:${response.statusCode}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입이 완료 되었습니다.');
      Get.back();
    } else {
      Fluttertoast.showToast(msg: '[${response.statusCode}] 에러 발생.');
    }
  } catch (e) {
      print("서버에 접근할 수 없음: $e");
      Fluttertoast.showToast(msg: '서버에 접근할 수 없습니다. 인터넷 연결을 확인하세요.');
    }
  }
}

