import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/login/sign_in.dart';
import 'package:untitled/screen/navigator_page.dart';
import 'package:http/http.dart' as http;

import 'package:untitled/get_controller/url_controller.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  List<String> farmList = ['1번 양식장', '2번 양식장', '3번 양식장', '4번 양식장'];
  String selectedFarm ='1번 양식장';
  List<bool> _selections1 = List.generate(2, (index) => false);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _farm = TextEditingController();

  DateTime date = DateTime.now();

  final controller = Get.put(UrlController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('imgs/background1.png'),
                        fit: BoxFit.fill
                    )
                ),),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .1),
                    child: Text(
                      '계정 만들기',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        wordSpacing: 4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          component1(Icons.mail,
                              '이메일', false, true, 1, _email),
                          component1(Icons.lock_outline,
                              '비밀번호', true, false, 2, _password),
                          component1(Icons.lock_outline,
                              '비밀번호 확인', true, false, 3, _password),
                          component1(Icons.person,
                              '이름', false, false, 4, _name),
                          birthSelect(Icons.calendar_today,
                              '생년월일', false, false),
                          toggleButton('남', '여'),
                          component1(Icons.phone_android,
                              '전화번호', false, false, 6, _number),
                          farmDropdown(Icons.house_siding, '소속 양식장'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('계정이 있으신가요?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                                )),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('로그인 하러 가기',
                                  style: TextStyle(
                                    fontSize: 12
                                  ),))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        component2(
                          '계정 생성', 2,
                              () {
                            if(_email.text.isEmpty || !_email.text.contains('@')) {
                              Fluttertoast.showToast(msg: '이메일을 확인해 주세요.');
                              return;
                            } else if (_password.text.isEmpty){
                              Fluttertoast.showToast(msg: '비밀번호를 확인해 주세요.');
                              return;
                            } else if (_name.text.isEmpty) {
                              Fluttertoast.showToast(msg: '이름을 확인해 주세요.');
                              return;
                            } else if (!(_selections1[0] || _selections1[1])) {
                              Fluttertoast.showToast(msg: '성별을 선택해 주세요.');
                              return;
                            } else if (_number.text.isEmpty) {
                              Fluttertoast.showToast(msg: '번호를 확인해 주세요.');
                              return;
                            }
                            String birth = '${date.year}-${date.month}-${date.day}';

                            controller.registerUser(_email.text, _password.text, _name.text,
                                birth, _gender.text, _number.text, _farm.text);


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
    );
  }

  Widget toggleButton(String one, String two) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.height / 20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ToggleButtons(
            children: [
              Text(one),
              Text(two),
            ],
            constraints: BoxConstraints.expand(
                height: size.width / 13,
                width: size.width / 1.2 / 2
            ),
            //disabledColor: Colors.white.withOpacity(.05),
            disabledColor: Colors.green,     // ???
            selectedColor: Colors.blue,    // 선택된 텍스트 컬러
            color: Colors.white,           // 미선택 텍스트 컬러
            fillColor: Colors.grey.withOpacity(0.2),       // 선택된 배경 컬러
            renderBorder: false,
            borderRadius: BorderRadius.circular(8),
            onPressed: (int index) {
              setState(() {
                if(index == 0) {
                  _selections1[0] = !_selections1[0];
                  _selections1[1] = false;
                  if (_selections1[0] == true) {
                    _gender.text = 'M';
                  }
                } else {
                  _selections1[0] = false;
                  _selections1[1] = !_selections1[1];
                  if (_selections1[1] == true) {
                    _gender.text = 'F';
                  }
                }
              });
            },
            isSelected: _selections1,
          ),
        ),
      ),
    );
  }


  Widget farmDropdown(IconData icon, String hintText) {
    Size size = MediaQuery.of(context).size;
    _farm.text = '1번 양식장';
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
          child: DropdownButton<String>(
            value: _farm.text,
              onChanged: (String? value) {
                setState(() {
                  _farm.text = value!;
                });
              },
            items: farmList.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    SizedBox(width: 13),
                    Icon(icon, color: Colors.white.withOpacity(.7)),
                    SizedBox(width: 15),
                    Text(value,
                      style: TextStyle(color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
              );
            }).toList(),
            style: TextStyle(color: Colors.black.withOpacity(.8)),
            dropdownColor: Colors.grey, // 추가: 드롭다운 배경색 변경
            underline: SizedBox(), // 추가: 드롭다운 하단의 밑줄 제거
            isExpanded: true, // 추가: 드롭다운 확장 여부 설정
            hint: Text( // 추가: 드롭다운 선택 이전에 보여질 힌트 텍스트
              '소속 양식장을 선택 하세요.',
              style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }


  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, int key, TextEditingController controller) {
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
            key: ValueKey(key),
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

  Widget birthSelect(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
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
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(icon,
                    color: Colors.white.withOpacity(.7)),
              SizedBox(width: 10,),
              Text('생년월일',
               style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
              SizedBox(width: 40,),
              ElevatedButton(
                child: Text(
                    "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"
                ),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                    locale: const Locale('ko', ''),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      date = selectedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(.1),
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                ),
              ),
            ],
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