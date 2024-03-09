import 'package:ecommerce_app/business_logic/controllers/auth_controller.dart';
import 'package:ecommerce_app/route/route.dart';
import 'package:ecommerce_app/ui/responsive/size_config.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../widget/customDivider.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_ink_button.dart';

class Registration extends StatelessWidget {
  Registration({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RxBool _value = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Image.asset(
                      'assets/icons/logo.png',
                      width: 60.w,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 23.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    customFormField(
                        TextInputType.text, nameController, context, 'Name',
                        (value) {
                      if (value.isEmpty) {
                        return 'this field can\'t be empty';
                      }
                    }, prefixIcon: Icons.person_2_outlined),
                    SizedBox(
                      height: 10.h,
                    ),
                    customFormField(TextInputType.emailAddress, emailController,
                        context, 'Email', (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          // Check if the email contains "@"
                          if (!value.contains('@')) {
                            return 'Enter a valid email address';
                          }
                          // Check if the email contains ".com"
                          if (!value.contains('.com')) {
                            return 'Enter a valid email address';
                          }
                    }, prefixIcon: Icons.email_outlined),
                    SizedBox(
                      height: 10.h,
                    ),
                    customFormField(TextInputType.text, passwordController,
                        context, 'Password', (value) {
                      if (value.isEmpty) {
                        return 'this field can\'t be empty';
                      }
                    },
                        prefixIcon: Icons.remove_red_eye_outlined,
                        obsecureText: true),
                    Row(
                      children: [
                        Obx(
                              () => Checkbox(
                            value: _value.value,
                            onChanged: (value) {
                              _value.value = value!;
                            },
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'I accept all the ',
                                style: TextStyle(
                                  color: AppColors.grayColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.toNamed(termCondition),
                                text: 'Terms & Condition',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        width: 150.w,
                        height: 45.h,
                        child: customButton('Sign up', () {
                          if (_formKey.currentState!.validate() &&
                              _value.value == true) {
                            Get.find<AuthController>().signUp(
                                nameController.text,
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context);
                          } else {
                            print("failed");
                          }
                        })),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        customDivider(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Or'),
                        ),
                        customDivider()
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: customInkButton(
                            Image.asset('assets/icons/facebook.png'),
                          ),
                        ),
                        SizedBox(
                          width: 20.h,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: customInkButton(
                              Image.asset('assets/icons/search.png')),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.grayColor,
                          )),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(login),
                          text: 'Login',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w600))
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
