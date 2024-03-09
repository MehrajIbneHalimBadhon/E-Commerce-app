import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../route/route.dart';

class SplashController extends GetxController {

  final box = GetStorage();
  chooseScreen() {
    var value = box.read('user');
    if (value == null) {
      Get.offAndToNamed(intro);
    } else {
      Get.offAndToNamed(bottomNav);
    }
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => chooseScreen());
    super.onInit();
  }
}