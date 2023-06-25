
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/class/class.dart';
import '../layout/toast_message.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _current, _image;


  static List<String> imgText = [
    '_head',
    '_left',
    '_right',
    '_four',
    ' _five',
    '_six',
    '_seven',
    '_eight',
    '_nine',
    '_ten',
    '_eleven',
    '_twelve',
    '_thirteen',
    '_fourteen',
    '_fifteen',
    '_sixteen',
    '_seventeen'
  ];

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


  final List<Images> imageData = List.generate(17, (index) =>
      Images(imgName[index], imgText[index], null));

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
        for(i=0; i<=16; i++){
          if(imageData[i].name == _text) {
            imageData[i].imgPath = File(image!.path);
          }
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
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .width,
            child: Center(
                child: _current == null
                    ? const Text('No image')
                    : Image.file(File(_current!.path)))),
      ],
    );
  }

  Widget grid(Images images) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _text = images.name;
              _current = images.imgPath;
            });
          },
          child: Container(
            color: Colors.grey,
            width: MediaQuery
                .of(context)
                .size
                .width / 4,
            height: MediaQuery
                .of(context)
                .size
                .width / 4,
            child: Center(
                child: images.imgPath == null
                    ? const Text('No image')
                    : Image.file(File(images.imgPath!.path))),
          ),
        ),
        Text(images.name)
      ],
    );
  }

  Widget upgrid(Images images) {
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Center(
                          child: images.imgPath == null
                              ? const Text('No image')
                              : Image.file(File(images.imgPath!.path)),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 3.3,
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 3.3,
                child: Center(
                    child: images.imgPath == null
                        ? const Text('No image')
                        : Image.file(File(images.imgPath!.path))),
              ),
            ),
          ),
          Text(images.name)
        ],
      ),
    );
  }

  @override
  int i = 0;
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
                      for(i = 0; i <= 16; i++) ... [
                        grid(imageData[i]),
                        const SizedBox(width:5),
                      ]
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text("이미지 저장"),
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
                  ),
                  ElevatedButton(
                    child: const Text("이미지 업로드"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('정말 업로드 하시겠습니까?'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for(int i=0; i <= 14; i+=2) ... [
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            upgrid(imageData[i]),
                                            upgrid(imageData[i+1]),
                                          ],
                                      ),
                                    ],
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        upgrid(imageData[16]),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // 다이얼로그 닫기
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('업로드'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // 다이얼로그 닫기
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('닫기'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
}
