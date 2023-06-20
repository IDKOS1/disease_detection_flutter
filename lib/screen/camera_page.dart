import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import '../layout/toast_message.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image,
      _current,
      _head,
      _left,
      _right,
      _four,
      _five,
      _six,
      _seven,
      _eight,
      _nine,
      _ten,
      _eleven,
      _twelve,
      _thirteen,
      _fourteen,
      _fifteen,
      _sixteen,
      _seventeen;

  List<File?> imageList = [];
  String _text = '사진을 선택하시오';
  final picker = ImagePicker();

  //비동기 처리를 통해 카메라와 갤러리에서 이미지 호출
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.rear);

    // 가져온 이미지를 _image에 저장
    if (image != null) {
      setState(() {
        _image = File(image!.path);
        _current = _image;
        switch (_text) {
          case '머리':
            _head = _image;
            break;
          case '왼쪽 아가미':
            _left = _image;
            break;
          case '오른쪽 아가미':
            _right = _image;
            break;
          case '4':
            _four = _image;
            break;
          case '5':
            _five = _image;
            break;
          case '6':
            _six = _image;
            break;
          case '7':
            _seven = _image;
            break;
          case '8':
            _eight = _image;
            break;
          case '9':
            _nine = _image;
            break;
          case '10':
            _ten = _image;
            break;
          case '11':
            _eleven = _image;
            break;
          case '12':
            _twelve = _image;
            break;
          case '13':
            _thirteen = _image;
            break;
          case '14':
            _fourteen = _image;
            break;
          case '15':
            _fifteen = _image;
            break;
          case '16':
            _sixteen = _image;
            break;
          case '17':
            _seventeen = _image;
            break;
        }
      });
    }
  }

  //이미지를 보여주는 위젯
  Widget showImage() {
    return Column(
      children: [
        Text(_text),
        Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Center(
                child: _current == null
                    ? const Text('No image')
                    : Image.file(File(_current!.path)))),
      ],
    );
  }

  Widget grid(String part, File? index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _text = part;
              _current = index;
            });
          },
          child: Container(
            color: Colors.grey,
            width: 100,
            height: 100,
            child: Center(
                child: index == null
                    ? const Text('No image')
                    : Image.file(File(index!.path))),
          ),
        ),
        Text(part)
      ],
    );
  }

  Widget upgrid(String part, File? index) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: Center(
                          child: index == null
                              ? const Text('No image')
                              : Image.file(File(index.path)),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              color: Colors.grey,
              width: 80,
              height: 80,
              child: Center(
                  child: index == null
                      ? const Text('No image')
                      : Image.file(File(index!.path))),
            ),
          ),
          Text(part)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScaffoldMessenger(
      child: Scaffold(
          backgroundColor: const Color(0xfff4f3f9),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              showImage(),
              const SizedBox(
                height: 20.0,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      grid('머리', _head),
                      const SizedBox(width: 5),
                      grid('왼쪽 아가미', _left),
                      const SizedBox(width: 5),
                      grid('오른쪽 아가미', _right),
                      const SizedBox(width: 5),
                      grid('4', _four),
                      const SizedBox(width: 5),
                      grid('5', _five),
                      const SizedBox(width: 5),
                      grid('6', _six),
                      const SizedBox(width: 5),
                      grid('7', _seven),
                      const SizedBox(width: 5),
                      grid('8', _eight),
                      const SizedBox(width: 5),
                      grid('9', _nine),
                      const SizedBox(width: 5),
                      grid('10', _ten),
                      const SizedBox(width: 5),
                      grid('11', _eleven),
                      const SizedBox(width: 5),
                      grid('12', _twelve),
                      const SizedBox(width: 5),
                      grid('13', _thirteen),
                      const SizedBox(width: 5),
                      grid('14', _fourteen),
                      const SizedBox(width: 5),
                      grid('15', _fifteen),
                      const SizedBox(width: 5),
                      grid('16', _sixteen),
                      const SizedBox(width: 5),
                      grid('17', _seventeen),
                      const SizedBox(width: 5),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: const Icon(Icons.add_a_photo)),
                  FloatingActionButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: const Icon(Icons.wallpaper),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_image != null) {
                          toastmsg('저장완료');
                          GallerySaver.saveImage(_image!.path)
                              .then((value) => print('save value = $value'))
                              .catchError((err) {
                            print('error : ($err');
                          });
                        } else {
                          toastmsg('선택 이미지 없음');
                        }
                      },
                      child: const Text("이미지 저장")),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('정말 업로드 하시겠습니까?'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('머리', _head),
                                          upgrid('왼쪽 아가미', _left),
                                          upgrid('오른쪽 아가미', _right),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('4', _four),
                                          upgrid('5', _five),
                                          upgrid('6', _six),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('7', _seven),
                                          upgrid('8', _eight),
                                          upgrid('9', _nine),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('10', _ten),
                                          upgrid('11', _eleven),
                                          upgrid('12', _twelve),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('13', _thirteen),
                                          upgrid('14', _fourteen),
                                          upgrid('15', _fifteen),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          upgrid('16', _sixteen),
                                          upgrid('17', _seventeen),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // 다이얼로그 닫기
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('업로드'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // 다이얼로그 닫기
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('닫기'),
                                  ),
                                ],
                              );
                            });
                      },
                      child: const Text("이미지 업로드")),
                ],
              )
            ],
          )
      ),
    );
  }
}
