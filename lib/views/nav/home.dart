import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/business_logic/controllers/favourite_controller.dart';
import 'package:ecommerce_app/const/app_colors.dart';
import 'package:ecommerce_app/model/products.dart';
import 'package:ecommerce_app/model/user_favourite.dart';
import 'package:ecommerce_app/route/route.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:ecommerce_app/style/app_styles.dart';
import 'package:ecommerce_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../business_logic/controllers/cart_controller.dart';
import '../../model/cart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: RefreshIndicator(
              onRefresh: () => FireStoreDb().getProducts(),
              child: FutureBuilder(
                future: FireStoreDb().getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.toNamed(details,
                                  arguments: snapshot.data![index]),
                              child: Ink(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.grayColor
                                              .withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 3))
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            snapshot.data![index].thumbnail,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      Text(
                                        snapshot.data![index].title,
                                        style: TextStyle(fontSize: 14.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '\$ ${snapshot.data![index].price.toString()}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(child: Text("Something went wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  Product data;
  DetailsScreen({super.key, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FireStoreDb().checkFavourite(widget.data.id),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return IconButton(
                  onPressed: () async {
                    final favouriteDate = UserFavourite(
                      brand: widget.data.brand,
                      category: widget.data.category,
                      description: widget.data.description,
                      discountPercentage: widget.data.discountPercentage,
                      id: widget.data.id,
                      images: widget.data.images,
                      price: widget.data.price,
                      rating: widget.data.rating,
                      stock: widget.data.stock,
                      thumbnail: widget.data.thumbnail,
                      title: widget.data.title,
                    );
                    if (snapshot.data!.docs.isEmpty) {
                      await FireStoreDb().addToFavourite(favouriteDate);
                      Get.find<FavouriteController>().fetch();
                    } else {
                      Get.showSnackbar(
                        AppStyles().failedSnacBar('Already Added'),
                      );
                    }
                  },
                  icon: snapshot.data!.docs.isEmpty
                      ? const Icon(Icons.favorite_outline,)
                      : const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                );
              } else {
                return Container(); // Return an empty container
              }
            },
          )
        ],
        backgroundColor: AppColors.mandarinColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.data.images
                  .map(
                    (e) => Card(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CachedNetworkImage(
                          imageUrl: e,
                          height: 100.h,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.title,
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.data.description,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.grayColor),
                ),
                Text(
                  '\$ ${widget.data.price.toString()}',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mandarinColor),
                ),
                customButton('Add to Cart', () async {
                  final cartData = UserCart(
                      brand: widget.data.brand,
                      category: widget.data.category,
                      description: widget.data.description,
                      discountPercentage: widget.data.discountPercentage,
                      id: widget.data.id,
                      images: widget.data.images,
                      price: widget.data.price,
                      rating: widget.data.rating,
                      stock: widget.data.stock,
                      thumbnail: widget.data.thumbnail,
                      title: widget.data.title);
                  await FireStoreDb().addToCart(cartData);
                  Get.find<CartController>().fetch();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
