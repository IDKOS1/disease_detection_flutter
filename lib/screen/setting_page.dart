import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screen/login/sign_in.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Get.offAll(() => LoginPage());
                },
                child: Text('Log out')),
          ],
        )
    );
  }

}
