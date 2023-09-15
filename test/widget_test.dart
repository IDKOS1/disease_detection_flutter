import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class YourUploadScreen extends StatefulWidget {
  @override
  _YourUploadScreenState createState() => _YourUploadScreenState();
}

class _YourUploadScreenState extends State<YourUploadScreen> {
  bool showSpinner = false;

  Future<void> uploadImages(List<String> imagePaths) async {
    setState(() {
      showSpinner = true;
    });

    String url = 'YOUR_DJANGO_API_ENDPOINT'; // Django REST API 엔드포인트

    var request = http.MultipartRequest('POST', Uri.parse(url));

    for (String imagePath in imagePaths) {
      File imageFile = File(imagePath);
      var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType('image', 'jpeg')); // 파일 타입에 맞게 조정

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Images uploaded successfully');
      // 업로드 성공 처리
      toastmsg('업로드 완료');
    } else {
      print('Error uploading images: ${response.reasonPhrase}');
      // 업로드 실패 처리
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            List<String> imagePaths = []; // 업로드할 이미지 파일 경로 리스트

            // 이미지 경로 리스트를 채우는 로직
            // ...

            if (imagePaths.isNotEmpty) {
              await uploadImages(imagePaths);
            } else {
              // 업로드할 이미지 없음 처리
            }
          },
          child: Text('Upload Images'),
        ),
      ),
    );
  }

  void toastmsg(String msg) {
    // 토스트 메시지 표시 로직
    // ...
  }
}
