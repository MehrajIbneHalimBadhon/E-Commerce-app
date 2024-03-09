import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../business_logic/controllers/auth_controller.dart';
import '../../ui/responsive/size_config.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class FogetPassword extends StatelessWidget {
  FogetPassword({super.key});
  TextEditingController emailController = TextEditingController();
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
                      "Forget Password?",
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

                    SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: customButton('Reset', () {
                          if (_formKey.currentState!.validate()) {
                            Get.find<AuthController>().forgetPassword(
                                emailController.text.trim(),
                                context);
                          } else {
                            print("failed");
                          }
                        })),
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
