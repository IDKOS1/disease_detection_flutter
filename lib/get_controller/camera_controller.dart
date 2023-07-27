import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/class/image_class.dart';

class CameraPageController extends GetxController {
  final picker = ImagePicker();
  File? _image, _currentPath;
  String _currentName = '머리';

  static CameraPageController get to => Get.find();
  static List<String> imgName = [
    '머리',
    '왼쪽 아가미',
    '오른쪽 아가미',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
  ];
  //비동기 처리를 통해 카메라와 갤러리에서 이미지 호출
  final List<Images> imageData = List.generate(17, (index) =>
      Images(imgName[index], null));

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.rear);

    // 가져온 이미지를 _image에 저장
    if (image != null) {
        _image = File(image!.path);
        _currentPath = _image;
        for(int i=0; i<=16; i++){
          if(imageData[i].name == _currentName) {
            imageData[i].imgPath = File(image!.path);
          }
        }
    }
  }

  void pageChanged(int index) {
    _currentName = imageData[index].name;
    _currentPath = imageData[index].imgPath;
    update();
}


}