import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/login_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(
        onPressed: (){
          Get.offAll(() => LoginPage());
        },
        child: Text('Log out')));
  }
}
