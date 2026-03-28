


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'BottomScreens/AllDistributorsScreen.dart';
import 'BottomScreens/AllFranchiseScreen.dart';
import 'BottomScreens/Dashboard.dart';
import 'BottomScreens/ProfileScreen.dart';
import 'BottomScreens/SearchFilterScreen.dart';



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
    SearchFilterPage(),
    AllFranchisePage(),
    AllDistributorsPage(),
    CustomerProfileScreen(),

  ];

  final icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.business,
    Icons.group,
    Icons.person
  ];

  final labels = [
    "Home",
    "Search",
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              icons.length,
                  (i) => Flexible(   // 🔥 முக்கியம்
                flex: controller.index.value == i ? 2 : 1, // 🔥 selected பெரியது
                child: GestureDetector(
                  onTap: () => controller.changeTab(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.index.value == i
                          ? const Color(0xffF23E46)
                          : const Color(0xff3A3A3A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icons[i], color: Colors.white),

                        if (controller.index.value == i)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text(
                                labels[i],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
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
      ),
    );
  }
}