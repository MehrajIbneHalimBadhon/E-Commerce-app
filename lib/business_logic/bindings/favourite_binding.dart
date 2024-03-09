import 'package:ecommerce_app/business_logic/controllers/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(FavouriteController());
  }

}