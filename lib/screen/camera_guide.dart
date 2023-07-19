import 'package:flutter/material.dart';

class cameraGuide extends StatelessWidget {
  final String currentPart;
  const cameraGuide({
    required this.currentPart
  ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.black),
          children: [
            TextSpan(
              text: currentPart!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' 부위 촬영 예시',
            ),
          ],
        ),
      ),
      content: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              width: size.width / 1.5,

              child: Center(
                child: Image.asset('imgs/sampleFish.png'),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Text('촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명 촬영 가이드 설명')
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // 다이얼로그 닫기
            Navigator.of(context).pop();
          },
          child: const Text('닫기'),
        ),
      ],
    );
  }
}
