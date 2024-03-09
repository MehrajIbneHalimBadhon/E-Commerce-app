import 'package:ecommerce_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customInkButton(image){
  return Ink(
    height: 45.h,
    width: 45.h,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: AppColors.grayColor.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3)
        )
      ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: image,
    ),
  );
}