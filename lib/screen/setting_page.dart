import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/get_controller/url_controller.dart';
import 'package:untitled/layout/toast_message.dart';
import 'package:untitled/screen/login/sign_in.dart';

class SettingPage extends StatefulWidget {
  SettingPage();

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final controller = Get.put(UrlController());

  final TextEditingController _name = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey,
                      child: Icon(Icons.person, size: 50,),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Column(
                    children: [
                      Text('김철수',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Text('소속 양식장')
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    box.remove('token');
                    print('token: ${box.read('toekn')}');
                    Get.offAll(() => LoginPage());
                  },
                  child: Text('Log out')),
              ElevatedButton(
                  onPressed: () async {
                    final boxToken = box.read('token');
                    print('box token: $boxToken');
                    bool isTrue = await controller.checkToken(boxToken);
                    print('bool = ${isTrue}');
                    toastmsg('${box.read('token')}');
                  },
                  child: Text('Check Token'))
            ],
          ),
        )
    );
  }

  Widget component1(String hintText, int key, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 17,
      width: size.width / 1.4,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        key: ValueKey(key),
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
