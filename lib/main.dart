import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/get_controller/url_controller.dart';
import 'package:untitled/screen/login/sign_in.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled/screen/navigator_page.dart';

void main() async {
  await GetStorage.init();
  final box = GetStorage();
  String? token = box.read('token');
  print('토큰(메인):$token');
  final controller = Get.put(UrlController());

  Future<bool> checkToken = controller.checkToken(token);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true
      ),
      home: await checkToken ? const NavigatorPage() : LoginPage(),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    ),
  );

}
