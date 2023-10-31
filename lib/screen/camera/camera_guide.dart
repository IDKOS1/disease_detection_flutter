import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/class/class.dart';
import 'package:untitled/get_controller/camera_controller.dart';

class cameraGuide extends StatelessWidget {
  final CameraPageController controller;
  const cameraGuide({
    required this. controller,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String guideTitle, guideText;
    PageController pageController = PageController(initialPage: controller.currentIndex.value);


    return Obx(() => PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      itemCount: controller.guideList.length,
      itemBuilder: (context, index) {
        if (index < 10) {
          guideTitle = '외형 촬영';
          guideText = '빛 반사를 최소로 줄이기 위하여\n체표 물기 및 점액질 제거 후 촬영';
        } else {
          guideTitle = '내부 촬영';
          guideText = '물기 제거 없이 최대한\n빛 반사를 적게하여 촬영';
        }
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 20, color: Colors.black),
              children: [
                TextSpan(
                  text: controller.guideList[index].name,
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
          content: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text('각도 예시',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Image.asset('imgs/guide_images/Guide00.png'),
                      SizedBox(height: 10),
                      Text('촬영 예시',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                      Image.asset(controller.guideList[index].imgPath),
                      SizedBox(height: 40),
                      Text(guideTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(height: 10),
                      Text(guideText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),)
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text('')
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 다이얼로그 닫기
                Get.back();
              },
              child: const Text('닫기'),
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
      onPageChanged: (index) {
        controller.pageChanged(index);
      },
    ),
    );
  }
}