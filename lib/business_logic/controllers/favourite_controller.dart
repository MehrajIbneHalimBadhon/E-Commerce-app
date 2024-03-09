import 'package:ecommerce_app/model/user_favourite.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{
  RxList<UserFavourite> items = RxList<UserFavourite>([]);

  fetch() async{
    var favItems = await FireStoreDb().getFavouriteItems();
    items.value = favItems;
  }
  @override
  void onInit() {
    fetch();
    super.onInit();
  }
}