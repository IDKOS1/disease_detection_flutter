import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:untitled/get_controller/url_controller.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  List<String> farmList = ['1번 양식장', '2번 양식장', '3번 양식장', '4번 양식장'];
  List<bool> _selections1 = List.generate(2, (index) => false);
  String selectedFarm = '1번 양식장';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _number = TextEditingController();


  DateTime date = DateTime.now();

  final controller = Get.put(UrlController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => ModalProgressHUD(
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
                                '비밀번호 확인', true, false, 3, _passwordCheck),
                            component1(Icons.person,
                                '이름', false, false, 4, _name),
                            birthSelect(Icons.calendar_today,
                                '생년월일', false, false),
                            toggleButton('남', '여'),
                            component1(Icons.phone_android,
                                '전화번호', false, false, 6, _number),
                            farmDropdown(Icons.house_siding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('계정이 있으신가요?',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('로그인 하러 가기',
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
                                () async {
                              controller.showSpinner.value = true;
                              if(_email.text.isEmpty || !_email.text.contains('@')) {
                                Fluttertoast.showToast(msg: '이메일을 확인해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (_password.text.isEmpty){
                                Fluttertoast.showToast(msg: '비밀번호를 확인해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              }  else if (_passwordCheck.text.isEmpty){
                                Fluttertoast.showToast(msg: '비밀번호 확인을 입력 해주세요');
                                controller.showSpinner.value = false;
                                return;
                              } else if (_password.text != _passwordCheck.text){
                                Fluttertoast.showToast(msg: '비밀번호와 비밀번호 확인이 다릅니다.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (_password.text.length < 8){
                                Fluttertoast.showToast(msg: '비밀번호를 8자리 이상 입력해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (_name.text.isEmpty) {
                                Fluttertoast.showToast(msg: '이름을 확인해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (!(_selections1[0] || _selections1[1])) {
                                Fluttertoast.showToast(msg: '성별을 선택해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (_number.text.isEmpty) {
                                Fluttertoast.showToast(msg: '번호를 확인해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              } else if (!_number.text.isNum) {
                                Fluttertoast.showToast(msg: '전화번호는 숫자만 입력해 주세요.');
                                controller.showSpinner.value = false;
                                return;
                              }
                              String birth = '${date.year}-${date.month}-${date.day}';

                              await controller.registerUser(_email.text, _password.text, _name.text,
                                  birth, _gender.text, _number.text, selectedFarm);

                              controller.showSpinner.value = false;
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
    )
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
            children: [
              Text(one),
              Text(two),
            ],
          ),
        ),
      ),
    );
  }


  Widget farmDropdown(IconData icon) {
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
          child: DropdownButton<String>(
            value: selectedFarm,
            onChanged: (String? value) {
              setState(() {
                selectedFarm = value!;
                print('farm: $selectedFarm');
              });
            },
            items: farmList.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    const SizedBox(width: 13),
                    Icon(icon, color: Colors.white.withOpacity(.7)),
                    const SizedBox(width: 15),
                    Text(value,
                      style: TextStyle(color: Colors.white.withOpacity(.8)),
                    ),
                  ],
                ),
              );
            }).toList(),
            style: TextStyle(color: Colors.black.withOpacity(.8)),
            dropdownColor: Colors.grey, // 추가: 드롭다운 배경색 변경
            underline: const SizedBox(), // 추가: 드롭다운 하단의 밑줄 제거
            isExpanded: true, // 추가: 드롭다운 확장 여부 설정

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
              const SizedBox(width: 10),
              Icon(icon,
                  color: Colors.white.withOpacity(.7)),
              const SizedBox(width: 10),
              Text('생년월일',
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
              const SizedBox(width: 40,),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: date,
                    dateFormat: "yyyy-MM-dd",
                    locale: DateTimePickerLocale.en_us,
                    looping: true,
                    confirmText: '확인',
                    cancelText: '취소',
                    titleText: '',
                  );
                  if (selectedDate != null) {
                    setState(() {
                      date = selectedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: Text(
                    "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}"
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

class SiguUpController extends GetxController {
  static SiguUpController get to => Get.find();

}