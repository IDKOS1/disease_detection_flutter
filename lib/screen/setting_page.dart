import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/get_controller/url_controller.dart';
import 'package:untitled/layout/toast_message.dart';
import 'package:untitled/screen/login/sign_in.dart';

class SettingPage extends StatelessWidget {
  SettingPage();

  final controller = Get.put(UrlController());
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  print('token: $boxToken');
                  toastmsg('${box.read('token')}');
                },
                child: Text('Check Token'))
          ],
        )
    );
  }
}
