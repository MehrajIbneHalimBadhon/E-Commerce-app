import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/model/user_favourite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart.dart';
import '../model/user_profile.dart';

class FireStoreDb {
  var box = GetStorage();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<UserProfile> getUserProfile() async {
    final snapshot = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    final userData =
        snapshot.docs.map((e) => UserProfile.fromSnapshot(e)).single;

    return userData;
  }

  Future<void> userProfileUpdate(UserProfile user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .update(user.toJson())
        .then((value) => Get.snackbar('Success', 'Updated successful'));
  }

  Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      List<Product> products = snapshot.docs.map((doc) {
        return Product.fromSnapshot(doc);
      }).toList();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      // You can handle the error here, e.g., by returning an empty list or rethrowing the error.
      rethrow; // Rethrow the error to propagate it to the caller.
    }
  }

  Future<void> addToFavourite(UserFavourite favourite) async {
    await firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.snackbar('Success', 'Added Successfully'));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkFavourite(
      int productId) async* {
    yield* firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .where('id', isEqualTo: productId)
        .snapshots();
  }

  Future<List<UserFavourite>> getFavouriteItems() async {
    final snapshot = await firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final favouriteDate =
        snapshot.docs.map((e) => UserFavourite.fromSnapshot(e)).toList();
    return favouriteDate;
  }

  Future<void>deleteFromFavourite(String? documentID)async{
    await firebaseFirestore.collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentID)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }

  Future<void> addToCart(UserCart favourite) async {
    await firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.rawSnackbar(message: 'Added To Cart'));
  }

  Future<List<UserCart>> getCartItems() async {
    final snapshot = await firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final cartData =
    snapshot.docs.map((e) => UserCart.fromSnapshot(e)).toList();

    return cartData;
  }

  Future<void> deleteFromCart(String? documentId) async {
    await firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }

}
