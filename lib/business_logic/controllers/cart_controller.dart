
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:get/get.dart';

import '../../model/cart.dart';

class CartController extends GetxController{
  RxList<UserCart> items = RxList<UserCart>([]);

  fetch() async{
    var cartItems = await FireStoreDb().getCartItems();
    items.value = cartItems;
  }
  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  int get getTotal=>items.fold(0, (previousValue, element) => previousValue + element.price);
}