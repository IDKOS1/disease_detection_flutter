import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/get_controller/willPop_controller.dart';
import 'package:untitled/screen/login/sign_up.dart';
import 'package:untitled/screen/navigator_page.dart';

import '../../get_controller/url_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final controller = Get.put(UrlController());
  final box = GetStorage();
  WillPopController popController = WillPopController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => WillPopScope(
      onWillPop: () async => popController.handleWillPopScopeAction(),
      child: ModalProgressHUD(
        inAsyncCall: controller.showSpinner.value,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('imgs/background1.png'),
                              fit: BoxFit.fill
                          )
                      ),),
                    Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * .1),
                            child: Text(
                              '수산질병 판독 시스템',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.7),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                wordSpacing: 4,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              component1(
                                  Icons.email, '이메일', false, true, _email),
                              component1(
                                  Icons.lock_outline, '비밀번호', true, false, _password),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  component2(
                                    '로그인',
                                    2.58,
                                        () async {
                                          controller.showSpinner.value = true;
                                          if(_email.text.isEmpty || !_email.text.contains('@')) {
                                            Fluttertoast.showToast(msg: '이메일을 확인해 주세요.');
                                            controller.showSpinner.value = false;
                                            return;
                                          } else if (_password.text.isEmpty){
                                            Fluttertoast.showToast(msg: '비밀번호를 입력해 주세요.');
                                            controller.showSpinner.value = false;
                                            return;
                                          }
                                          await controller.tryLogin(_email.text, _password.text);
                                    },
                                  ),
                                  SizedBox(width: size.width / 20),
                                  component2(
                                    '회원 찾기',
                                    2.58,
                                        () async {
                                      print(box.read('token'));
                                      Fluttertoast.showToast(msg: '로그인 되었습니다.');
                                      Get.offAll(() => NavigatorPage());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              component2(
                                '회원가입',
                                2,
                                    () {
                                  Get.to(()=>SignUpPage());
                                },
                              ),
                              SizedBox(height: size.height * .05),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    ));
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.height / 17,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
            isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.height / 17,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Colors.white.withOpacity(.8)),
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}