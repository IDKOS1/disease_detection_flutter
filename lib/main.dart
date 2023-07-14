import 'package:flutter/material.dart';
import 'package:untitled/bottom_navigator_bar.dart';




void main() =>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorSchemeSeed: Colors.blue,
          useMaterial3: true
        ),
        home: NaviswipeState(),
    );
  }
}




