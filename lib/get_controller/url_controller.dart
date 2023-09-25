import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screen/navigator_page.dart';


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

    print("응답코드: ${response.statusCode}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입이 완료 되었습니다.');
      print("token${json.decode(response.body)["Token"]}");
      Get.back();
    } else {
      Fluttertoast.showToast(msg: '[${response.statusCode}] 에러 발생.');
    }
  } catch (e) {
      print("서버에 접근할 수 없음: $e");
      Fluttertoast.showToast(msg: '서버에 접근할 수 없습니다. 인터넷 연결을 확인하세요.');
    }
  }

  Future<void> tryLogin (String email, String password) async {
    final box = GetStorage();
    print(url.resolve('/register/login/'));
    showSpinner.value = true;
    try{
      final response = await http.post(
          url.resolve('/register/login/'),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String> {
            'email': email,
            'password': password,
          })
      ).timeout(const Duration(seconds: 20));
      final responseData = json.decode(response.body);

      print("응답코드: ${response.statusCode}");
      if (response.statusCode == 200 && responseData["token"] != null) {
        print("토큰 ${responseData["token"]}");
        String token = responseData["token"];
        box.write('token', token);
        Fluttertoast.showToast(msg: responseData["token"]);
        print("token: $token");
        showSpinner.value = false;
        Get.offAll(() => NavigatorPage());
      } else {
        print(responseData["message"]);
        showSpinner.value = false;
        Fluttertoast.showToast(msg: '${responseData["message"]}');
      }
    } catch (e) {
      showSpinner.value = false;
      print("에러 발생: $e");
      Fluttertoast.showToast(msg: '에러 발생 $e');
    }
  }

  Future<bool> checkToken (String? token) async {
    print('토큰:$token');
    if (token != null) {
      try {
        final response = await http.post(
            url.resolve('/register/checkToken/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token'
            },
        ).timeout(const Duration(seconds: 20));
        print("응답코드: ${response.statusCode}");
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: '로그인 되었습니다.');
          return true;
        } else {
          print(json.decode(response.body)["message"]);
          return false;
        }
      } catch (e) {
        print('error:$e');
        return false;
      }
    } else {
      print('토큰 없음');
      return false;
    }
  }
}

