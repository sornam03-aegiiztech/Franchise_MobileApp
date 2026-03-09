


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'BottomScreens/AllDistributorsScreen.dart';
import 'BottomScreens/AllFranchiseScreen.dart';
import 'BottomScreens/Dashboard.dart';
import 'BottomScreens/ProfileScreen.dart';



class BottomController extends GetxController {
  var index = 0.obs;

  void changeTab(int i) {
    index.value = i;
  }
}

class CustomerBottomBarScreen extends StatelessWidget {
  CustomerBottomBarScreen({super.key});

  final BottomController controller = Get.put(BottomController());

  final pages = [
    CustomerHomePage(),
    AllFranchisePage(),
    AllDistributorsPage(),
    CustomerProfileScreen(),

  ];

  final icons = [
    Icons.home_rounded,
    Icons.business,
    Icons.group,
    Icons.person
  ];

  final labels = [
    "Home",
    "Franchise",
    "Distributors",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),

      body: Obx(() => pages[controller.index.value]),

      bottomNavigationBar: Obx(
            () => Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xff2B2B2B),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              icons.length,
                  (i) => GestureDetector(
                onTap: () => controller.changeTab(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: controller.index.value == i
                      ? const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  )
                      : const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: controller.index.value == i
                        ? const Color(0xffF23E46)
                        : const Color(0xff3A3A3A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icons[i],
                        color: Colors.white,
                      ),

                      if (controller.index.value == i)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            labels[i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}