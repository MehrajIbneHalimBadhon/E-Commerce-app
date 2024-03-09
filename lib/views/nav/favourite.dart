import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/business_logic/controllers/favourite_controller.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final controller = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Ink(
                          height: 200,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.grayColor.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.items[index].thumbnail,
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
                                controller.items[index].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '\$ ${controller.items[index].price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                FireStoreDb().deleteFromFavourite(
                                    controller.items[index].documentId);
                                controller.fetch();
                              },
                              icon: const Icon(Icons.remove_circle_outline)))
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
