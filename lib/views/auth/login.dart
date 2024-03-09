import 'package:ecommerce_app/const/app_colors.dart';
import 'package:ecommerce_app/route/route.dart';
import 'package:ecommerce_app/ui/responsive/size_config.dart';
import 'package:ecommerce_app/widget/custom_button.dart';
import 'package:ecommerce_app/widget/custom_ink_button.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:ecommerce_app/widget/customDivider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../business_logic/controllers/auth_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: SizeConfig.screenHeight,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
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
                      "Log in",
                      style: TextStyle(
                          fontSize: 23.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 50.h,
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
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Get.toNamed(forgetPass),
                        child: Text(
                          'Forget Password',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        width: 150.w,
                        height: 45.w,
                        child: customButton(
                          'Login',
                          () {
                            // Inside the onPressed method of the login button
                            if (_formKey.currentState!.validate()) {
                              Get.find<AuthController>().signIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context,
                              );
                            } else {
                              print('Failed to validate form');
                            }
                          },
                        )),
                    SizedBox(
                      height: 20.h,
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
                    const SizedBox(
                      height: 20,
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
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: customInkButton(
                              Image.asset('assets/icons/search.png')),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(TextSpan(children: [
                      const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: AppColors.grayColor,
                          )),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(registration),
                          text: 'Sign up',
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
