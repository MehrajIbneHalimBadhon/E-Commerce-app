import 'package:ecommerce_app/business_logic/bindings/auth_binding.dart';
import 'package:ecommerce_app/business_logic/bindings/cart_binding.dart';
import 'package:ecommerce_app/business_logic/bindings/splash_binding.dart';
import 'package:ecommerce_app/views/auth/forget_password.dart';
import 'package:ecommerce_app/views/auth/login.dart';
import 'package:ecommerce_app/views/auth/registration.dart';
import 'package:ecommerce_app/views/bottom_navigation.dart';
import 'package:ecommerce_app/views/nav/adminHome.dart';
import 'package:ecommerce_app/views/nav/cart.dart';
import 'package:ecommerce_app/views/nav/favourite.dart';
import 'package:ecommerce_app/views/nav/home.dart';
import 'package:ecommerce_app/views/nav/profile.dart';
import 'package:ecommerce_app/views/not_found.dart';
import 'package:ecommerce_app/views/onboarding.dart';
import 'package:ecommerce_app/views/splash.dart';
import 'package:ecommerce_app/views/terms_condition.dart';
import 'package:get/get.dart';

import '../business_logic/bindings/favourite_binding.dart';

const String splash = '/splash-screen';
const String unknown = '/not-found';
const String intro = '/intro';
const String login = '/login';
const String registration = '/registration';
const String forgetPass = '/forgetPass';
const String termCondition = '/termCondition';
const String bottomNav = '/bottomNav';
const String cart = '/cart';
const String favourite = '/favourite';
const String home = '/home';
const String profile = '/profile';
const String details = '/details';
const String adminHome = '/adminHome';

List<GetPage> getPages = [
  GetPage(name: unknown, page: () => const UnKnown()),
  GetPage(name: splash, page: () => const Splash(), binding: SplashBinding()),
  GetPage(name: intro, page: () => const OnBoarding()),
  GetPage(name: login, page: () => Login(), binding: AuthBinding()),
  GetPage(
      name: registration, page: () => Registration(), binding: AuthBinding()),
  GetPage(
      name: forgetPass, page: () => FogetPassword(), binding: AuthBinding()),
  GetPage(name: termCondition, page: () => const TermCondition()),
  GetPage(name: bottomNav, page: () => const BottomNavigation(),bindings: [
    CartBinding(),
    FavouriteBinding(),
  ]),
  GetPage(name: cart, page: () =>  Cart()),
  GetPage(name: favourite, page: () =>  const Favourite()),
  GetPage(name: home, page: () =>  const Home()),
  GetPage(name: profile, page: () => Profile()),
  GetPage(name: adminHome, page: () => const AdminHome()),
  GetPage(
    name: details,
    page: () => DetailsScreen(
      data: Get.arguments,
    ),
  ),
];
