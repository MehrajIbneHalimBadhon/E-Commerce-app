import 'package:bubble_navigation_bar/bubble_navigation_bar.dart';
import 'package:ecommerce_app/const/app_colors.dart';
import 'package:ecommerce_app/views/nav/cart.dart';
import 'package:ecommerce_app/views/nav/favourite.dart';
import 'package:ecommerce_app/views/nav/home.dart';
import 'package:ecommerce_app/views/nav/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    var index = 0.obs;

    pageController.addListener(() {
      index.value = pageController.page!.round();
    });

    return Obx(() => Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          const Home(),
          const Favourite(),
          Cart(),
          Profile(),

        ],
      ),
      bottomNavigationBar: BubbleNavigationBar(
        currentIndex: index.value,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.mandarinColor,
        unselectedItemColor: AppColors.mandarinColor,
        onIndexChanged: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 80),
            curve: Curves.decelerate,
          );
        },
        items: const [
          BubbleNavItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BubbleNavItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favourite',
          ),
          BubbleNavItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Cart',
          ),
          BubbleNavItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}
