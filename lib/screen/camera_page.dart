
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/class/image_class.dart';
import '../layout/toast_message.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _current, _image;

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
      Images(imgName[index], null));

  String _text = '머리';
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
        for(int i=0; i<=16; i++){
          if(imageData[i].name == _text) {
            imageData[i].imgPath = File(image!.path);
          }
        }
      });
    }
  }

  final PageController _pageController = PageController();

  //이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
      height: MediaQuery.of(context).size.width-8,
      width: MediaQuery.of(context).size.width-8,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageData.length,
              itemBuilder: (context, index) {
                final images = imageData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: images.imgPath == null
                          ? Center(child: const Text('이미지를 촬영해 주세요!'))
                          : Image.file(File(images.imgPath!.path),
                      ),
                    ),
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _text = imageData[index].name;
                  _current = imageData[index].imgPath;
                });
              },
            ),
          ),
          Text(
            _text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }


  Widget _list(Images images) {
    bool isSelected = _text == images.name;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _text = images.name;
              _current = images.imgPath;
            });
            final index = imageData.indexWhere((item) => item.name == images.name);
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );

          },
          child: Container(
            decoration: BoxDecoration(
              border: isSelected
                  ? Border(
                  bottom: BorderSide(
                    color: Colors.green,
                    width: 2.0,
                  )
              )
                  : null,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Center(
                child: Text(images.name,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : null,
                    fontSize: 18,
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }

  Widget _upgrid(Images images) {
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
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScaffoldMessenger(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xfff4f3f9),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('수산질병 판독 촬영',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('촬영예시',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Icon(Icons.camera_alt, color: Colors.blue,),
                    SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(int i = 0; i <= 16; i++) ... [
                          _list(imageData[i]),
                          const SizedBox(width:5),
                        ]
                      ],
                    )),
                const SizedBox(height: 5.0),
                showImage(),
                const SizedBox(height: 20.0),
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
                const SizedBox(height: 25),
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
                                title: const Text('정말 업로드 하시겠습니까?',
                                  style: TextStyle(fontSize: 20),),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      for(int i=0; i <= 14; i+=2) ... [
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              _upgrid(imageData[i]),
                                              _upgrid(imageData[i+1]),
                                            ],
                                        ),
                                      ],
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          _upgrid(imageData[16]),
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
      ),
    );
  }
}
