import 'package:ecommerce_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(title, onpressed) {
  return ElevatedButton(onPressed: onpressed,style:
    ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColors.mandarinColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 15.sp
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24)
    ),
      child: Text(title),);
}
