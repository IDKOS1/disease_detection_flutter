import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/class/class.dart';

class CameraPageController extends GetxController {
  static CameraPageController get to => Get.find();
  RxInt currentIndex = 0.obs;
  static List<String> imgName = [
    '유안측 0도',
    '유안측 45도',
    '유안측 90도',
    '유안측 분할 좌',
    '유안측 분할 우',
    '무안측 0도',
    '무안측 45도',
    '무안측 90도',
    '무안측 분할 좌',
    '무안측 분할 우',
    '아가미, 간 45도',
    '아가미, 간 90도',
    '아가미 뚜껑',
    '장, 비장 45도',
    '장, 비장 90도',
    '내장 제거 후 45도',
    '내장 제거 후 90도'
  ];

  static List<String> imgPath = [
    'imgs/guide_images/Guide01.png',
    'imgs/guide_images/Guide02.png',
    'imgs/guide_images/Guide03.png',
    'imgs/guide_images/Guide04.png',
    'imgs/guide_images/Guide05.png',
    'imgs/guide_images/Guide06.png',
    'imgs/guide_images/Guide07.png',
    'imgs/guide_images/Guide08.png',
    'imgs/guide_images/Guide09.png',
    'imgs/guide_images/Guide10.png',
    'imgs/guide_images/Guide11.png',
    'imgs/guide_images/Guide12.png',
    'imgs/guide_images/Guide13.png',
    'imgs/guide_images/Guide14.png',
    'imgs/guide_images/Guide15.png',
    'imgs/guide_images/Guide16.png',
    'imgs/guide_images/Guide17.png'
  ];

  final RxList<Guide> guideList = RxList<Guide>.from(List.generate(17, (index) =>
      Guide(imgName[index], imgPath[index])));

  //비동기 처리를 통해 카메라와 갤러리에서 이미지 호출
  final RxList<Images> imageData = RxList<Images>.from(List.generate(17, (index) =>
      Images(imgName[index], null)));

  final picker = ImagePicker();
  //Rx<File> currentPath = Rx<File>(File(''));
  Rx<String?> currentName = '유안측 0도'.obs;

  // 카메라 혹은 갤러리에서 불러온 이미지를 현재 선택한 부위와 동일 이름 리스트에 저장
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.rear);

    if (image != null) {
        for(int i=0; i<=16; i++){
          if(imageData[i].name == currentName.toString()) {
            imageData[i].imgPath = File(image!.path);
            imageData.refresh();
          }
        }
    }
  }



  void pageChanged(int index) {
    currentName.value = imageData[index].name;
    currentIndex.value = index;
    print('current index = ${index}');
    print('index.value = ${currentIndex.value}');
    print('name.value= ${currentName.value}');
  }
}