import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/class/image_class.dart';
import 'package:untitled/get_controller/camera_controller.dart';
import 'package:untitled/layout/toast_message.dart';
import 'package:untitled/screen/camera/camera_guide.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  var controller = CameraPageController();

  final PageController _pageController = PageController();

  //이미지를 보여주는 위젯
  Widget showImage() {
    final heightSize = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: heightSize /2.3,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: controller.imageData.length,
            itemBuilder: (context, index) {
              final images = controller.imageData[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: heightSize / 2.5,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: images.imgPath == null
                              ? const Center(child: Text('이미지를 촬영해 주세요!'))
                              : Image.file(File(images.imgPath!.path),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            onPageChanged: (index) {
                controller.pageChanged(index);
            },
          ),
        ),
        Text(
          controller._currentName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );

          },
          child: Container(
            decoration: BoxDecoration(
              border: isSelected
                  ? Border(
                  bottom: BorderSide(
                    color: Colors.lightGreen[200]!,
                    width: 2.0,
                  )
              )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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

  Widget _upGrid(Images images) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.width/3,
          width: size.width/3,
          child: InkWell(
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
                        height: size.height / 1.7,
                        child: Center(
                          child: images.imgPath == null
                              ? const Text('사진이 없어요')
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
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Center(
                        child: images.imgPath == null
                            ? const Text('사진이 없어요',
                          style: TextStyle(
                              fontSize: 10
                          ),)
                            : Image.file(File(images.imgPath!.path))
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(images.name)
      ],
    );
  }

  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final size = MediaQuery.of(context).size;


    return ScaffoldMessenger(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xfff4f3f9),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('수산질병 판독 촬영',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 10,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return cameraGuide(
                                        currentPart: _text,
                                      );
                                    }
                                );
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Text('촬영예시',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    Icon(Icons.camera_alt, color: Colors.blue,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                          ],
                        ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for(int i = 0; i <= 16; i++) ... [
                                _list(imageData[i]),
                              ]
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(width:5),
                showImage(),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              heroTag: 'camera',
                              child: const Icon(Icons.add_a_photo)),
                          FloatingActionButton(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            heroTag: 'gallery',
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

                            },
                          ),

                          ElevatedButton(
                            child: const Text("이미지 업로드"),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return ModalProgressHUD(
                                          inAsyncCall: showSpinner,
                                          child: AlertDialog(
                                            title: const Text('정말 업로드 하시겠습니까?',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  for(int i=0; i <= 14; i+=2) ... [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        _upGrid(imageData[i]),
                                                        _upGrid(imageData[i+1]),
                                                      ],
                                                    ),
                                                  ],
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      _upGrid(imageData[16]),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    showSpinner = true;
                                                  });
                                                  print('${showSpinner}');

                                                  for (Images item in imageData) {
                                                    if (item.imgPath != null) {
                                                      await GallerySaver.saveImage(item.imgPath!.path)
                                                          .then((value) => print('save value = $value'))
                                                          .catchError((err) {
                                                        print('error : ($err');
                                                      });
                                                    } else {
                                                      //toastmsg('선택 이미지 없음');
                                                    }
                                                  }
                                                  for (Images item in imageData) {
                                                    item.imgPath = null;
                                                  }
                                                  setState(() {
                                                    showSpinner = false;
                                                  });
                                                  print('${showSpinner}');

                                                  toastmsg('업로드 완료');
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
                                          ),
                                        );
                                      }
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
