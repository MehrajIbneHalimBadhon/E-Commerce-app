import 'package:ecommerce_app/const/app_colors.dart';
import 'package:ecommerce_app/model/intro.dart';
import 'package:ecommerce_app/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroScreenOnboarding(
          backgroudColor: Colors.transparent,
          introductionList: introData
              .map((e) => Introduction(
                  imageHeight: 230.h,
                  titleTextStyle:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                  subTitleTextStyle:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w300),
                  imageUrl: e.image,
                  title: e.title,
                  subTitle: e.description))
              .toList(),
          onTapSkipButton: () => Get.offAndToNamed(login),
          foregroundColor: AppColors.mandarinColor,

        ),
      ),
    );
  }
}
