import 'package:ecommerce_app/model/user_profile.dart';
import 'package:ecommerce_app/services/firestore_db.dart';
import 'package:ecommerce_app/widget/custom_button.dart';
import 'package:ecommerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController uidController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: FireStoreDb().getUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserProfile userProfile = snapshot.data as UserProfile;
                  nameController.text = userProfile.name;
                  emailController.text = userProfile.email;
                  uidController.text = userProfile.uid;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100, left: 25, right: 25),
                      child: Column(
                        children: [
                          customFormField(TextInputType.text, nameController,
                              context, 'user name', (val) {},
                              prefixIcon: Icons.person_outline),
                          customFormField(TextInputType.text, emailController,
                              context, 'email', (val) {},
                              prefixIcon: Icons.email_outlined, readOnly: true),
                          customFormField(TextInputType.text, uidController,
                              context, 'uid', (val) {},
                              prefixIcon: Icons.verified_outlined, readOnly: true),
                          customButton('Update Profile', () async{
                            final updateData = UserProfile(email: emailController.text.trim(), uid: uidController.text.trim(), name: nameController.text.trim());
                            await FireStoreDb().userProfileUpdate(updateData);
                          })
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Something Wrong",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
