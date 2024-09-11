import 'package:flutter/material.dart';

AppBar utilAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.black12, // 탑바 배경 색
    elevation: 0, // 그림자 효과를 없애려면 0으로 설정
    centerTitle: true, // 제목을 중앙에 배치
    automaticallyImplyLeading: true, // 자동으로 뒤로가기 버튼을 추가
    leading: IconButton(
      icon: const Icon(Icons.arrow_back), // 뒤로가기 아이콘
      onPressed: () {
        Navigator.pop(context); // 뒤로가기 기능
      },
    ),
  );
}