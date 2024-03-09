
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/route/route.dart';
import 'package:ecommerce_app/style/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();

  //sign in
  signUp(name, email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.uid.isNotEmpty) {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('users');
        collectionReference
            .doc(email)
            .set({
          'uid': credential.user!.uid,
          'email': email,
          'name': name,
        'role':'user'});

        Map user = {'uid': credential.user!.uid, 'email': email, 'name': name,'role':'user'};
        box.write('user', user);
        print(box.read('user'));
        Get.back();
        Get.offAndToNamed(bottomNav);
        Get.showSnackbar(AppStyles().successSnacBar('SignUp successfull'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.showSnackbar(
            AppStyles().failedSnacBar('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.showSnackbar(AppStyles()
            .failedSnacBar('The account already exists for that email.'));
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnacBar(e));
    }
  }

  Future<void> signIn(
      email,  password, context) async {
    AppStyles().progressDialog(context);
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();
        final Map<String, dynamic>? data = doc.data();

        if (data != null) {
          final String role = data['role'];

          if (role == 'admin') {
            Get.back();
            Get.offAndToNamed(adminHome);
            Get.showSnackbar(AppStyles().successSnacBar('Admin login successfull'));
          } else {
            Get.back();
            Get.offAndToNamed(bottomNav);
            Get.showSnackbar(AppStyles().successSnacBar('User login successfull'));
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        Get.showSnackbar(
            AppStyles().failedSnacBar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.showSnackbar(AppStyles()
            .failedSnacBar('Wrong password provided for that user.'));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // User login
  login(email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> doc) {
          if (doc.exists) {
            var data = doc.data();
            print(data);
            Map user = {
              'uid': data!['uid'],
              'email': data['email'],
              'name': data['name']
            };
            box.write('user', user);
            print(user);
            Get.back();
            Get.offAndToNamed(bottomNav);
            Get.showSnackbar(AppStyles().successSnacBar('Login successfull'));
          } else {
            Get.showSnackbar(AppStyles()
                .failedSnacBar('document does not exist on the database.'));
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        Get.showSnackbar(
            AppStyles().failedSnacBar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.showSnackbar(AppStyles()
            .failedSnacBar('Wrong password provided for that user.'));
      }
    }
  }







  //forgetpassword
  forgetPassword(email, context) async {
    try {
      AppStyles().progressDialog(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      Get.showSnackbar(
          AppStyles().successSnacBar('Email has been sent to $email)'));
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnacBar('Something is wrong.'));
    }
  }

  //logout
  logOut() async {
    await auth.signOut();
  }
}
