import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/class/class.dart';
import 'package:untitled/layout/toast_message.dart';
import 'package:untitled/screen/navigator_page.dart';


class UrlController extends GetxController {
  static UrlController get to => Get.find();

  // REAL URL
  final url = Uri.parse('http://211.41.73.17');
  //test url
  //final url = Uri.parse('http://10.0.2.2:8000');

  final box = GetStorage();
  RxBool showSpinner = false.obs;

  Future<void> registerUser(String email, String password, String username,
      String birth, String gender, String number, String farm) async {
    print(url.resolve('/register/signup/'));
    try {
      final response = await http.post(
          url.resolve('/register/signup/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
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
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: '${response.body}');
      } else {
        Fluttertoast.showToast(msg: '[${response.statusCode}] 에러 발생.');
      }
    } catch (e) {
      print("서버에 접근할 수 없음: $e");
      Fluttertoast.showToast(msg: '서버에 접근할 수 없습니다.');
    }
  }

  Future<void> tryLogin(String email, String password) async {
    print(url.resolve('/register/login/'));
    showSpinner.value = true;
    try {
      final response = await http.post(
          url.resolve('/register/login/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          })
      ).timeout(const Duration(seconds: 20));
      final responseData = json.decode(response.body);

      print("응답코드: ${response.statusCode}");
      if (response.statusCode == 200 && responseData["token"] != null) {
        print("토큰 ${responseData["token"]}");
        String token = responseData["token"];
        int id = responseData["id"];
        String name = responseData["name"];
        String farm = responseData["farm"];
        box.write('token', token);
        box.write('id', id);
        box.write('name', name);
        box.write('farm', farm);
        box.write('email', email);
        Fluttertoast.showToast(msg: responseData["token"]);
        print("token: $token");
        print("id: $id");
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
      Fluttertoast.showToast(msg: '서버에 접근할 수 없습니다.');
    }
  }

  Future<bool> checkToken() async {
    String? token = box.read('token');
    print('토큰: $token');

    if (token != null) {
      try {
        final response = await http.post(
          url.resolve('/register/checkToken/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Token $token',
          },
        ).timeout(const Duration(seconds: 20));
        final responseData = json.decode(response.body);

        print("응답코드: ${responseData["message"]}");
        String respons = responseData["message"];

        if (response.statusCode == 200) {
          box.write('token', token);

          Fluttertoast.showToast(msg: respons);
          return true;
        } else {
          Fluttertoast.showToast(msg: respons);
          return false;
        }
      } catch (e) {
        print('네트워크 오류: $e');
        return false;
      }
    } else {
      print('토큰 없음');
      return false;
    }
  }

  Future<List<Results>>? loadResult() async {
    print("loadResult");
    try {
      String? token = box.read('token');
      final response = await http.get(
        url.resolve('/register/loadResult/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
      ).timeout(const Duration(seconds: 20));

      print("응답코드: ${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.body);
        if(response.body == null) {
          return [];
        }
        final List<dynamic> jsonList = await json.decode(response.body);
        List<Results> resultsList = await jsonList.map((jsonItem) {
          return Results(
            location: jsonItem['location'],
            uploadDate: DateTime.parse(jsonItem['upload_date']),
            numberImages: int.parse(jsonItem['number_images'].toString()),
            isDone: bool.parse(jsonItem['is_done'].toString()),
            Edwardsiella: double.parse(jsonItem['Edwardsiella']),
            Vibrio: double.parse(jsonItem['Vibrio']),
            Streptococcus: double.parse(jsonItem['Streptococcus']),
            Tenacibaculumn: double.parse(jsonItem['Tenacibaculumn']),
            Enteromyxum: double.parse(jsonItem['Enteromyxum']),
            Miamiensis: double.parse(jsonItem['Miamiensis']),
            VHSV: double.parse(jsonItem['VHSV']),
          );
        }).toList();
        return resultsList;
      } else {
        Fluttertoast.showToast(msg: '[${response.statusCode}] 에러 발생.');
        return [];
      }
    } catch (e) {
      print("에러발생: $e");
      Fluttertoast.showToast(msg: '서버에 접근할 수 없습니다.');
      return [];
    }
  }
}