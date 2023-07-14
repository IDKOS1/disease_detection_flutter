import 'package:flutter/material.dart';
import 'package:untitled/screen/camera_page.dart';

class NaviswipeState extends StatefulWidget {
  const NaviswipeState({Key? key}) : super(key: key);

  @override
  State<NaviswipeState> createState() => _NaviswipeStateState();
}

class _NaviswipeStateState extends State<NaviswipeState> {
  int current_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: current_index,
            onTap: (index){
              setState(() {
                current_index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt),
                  label: '촬영'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload),
                  label: '결과 확인'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '설정'
              ),

            ],
            // 선택된 index 색상
            selectedItemColor: Theme.of(context).colorScheme.primary,
            // 미선택된 index 색상
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.shifting
          //BottomNavigationBarType.shifting : selected 된 item 확대
        ),
        body: Center(
          child: body_item[current_index],
        )
    );
  }

  List body_item = [
    CameraPage(),
    Text("message page"),
    Text("settings")
  ];
}