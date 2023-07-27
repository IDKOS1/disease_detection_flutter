import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  static BottomNavigationController get to => Get.find();

  RxInt _currentPage = 0.obs;
  RxInt get currentPage => _currentPage;

  void changeIndex(int index) {
    _currentPage(index);
  }
}