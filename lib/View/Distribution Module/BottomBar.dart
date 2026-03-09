// import 'package:flutter/material.dart';
// import 'package:franchaise_app/Constants/Colors.dart';
// import 'package:franchaise_app/View/Franchaise%20Module/BottomScreens.dart';
// import 'package:get/get.dart';
//
// class BottomBarController extends GetxController {
//   final currentIndex = 0.obs;
//
//   void changeIndex(int index) {
//     currentIndex.value = index;
//   }
// }
//
// class BottomBarClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//
//     const double cornerRadius = 24;
//
//     path.moveTo(cornerRadius, 0);
//
//     path.quadraticBezierTo(0, 0, 0, cornerRadius);
//
//     path.lineTo(0, size.height - cornerRadius);
//
//     path.quadraticBezierTo(0, size.height, cornerRadius, size.height);
//
//     path.lineTo(size.width - cornerRadius, size.height);
//
//     path.quadraticBezierTo(
//       size.width,
//       size.height,
//       size.width,
//       size.height - cornerRadius,
//     );
//
//     path.lineTo(size.width, cornerRadius);
//
//     path.quadraticBezierTo(size.width, 0, size.width - cornerRadius, 0);
//
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class BottomBarScreen extends StatelessWidget {
//   BottomBarScreen({super.key});
//
//   final BottomBarController controller = Get.put(BottomBarController());
//
//   final List<Widget> pages = const [
//     DashboardScreen(),
//     ExploreScreen(),
//     SearchScreen(),
//     ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: apptheme,
//
//       body: Obx(() => pages[controller.currentIndex.value]),
//
//       bottomNavigationBar: Obx(
//             () => SafeArea(
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             child: ClipPath(
//               clipper: BottomBarClipper(),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Color(0xff3F3F3F),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.12),
//                       blurRadius: 25,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: List.generate(
//                     _icons.length,
//                         (index) => _BottomBarItem(
//                       icon: _icons[index],
//                       label: _labels[index],
//                       isActive: controller.currentIndex.value == index,
//                       onTap: () => controller.changeIndex(index),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// ICONS
// const _icons = [
//   Icons.home_rounded,
//   Icons.explore_rounded,
//   Icons.search,
//   Icons.person_rounded,
// ];
//
// /// LABELS
// const _labels = [
//   "Home",
//   "Explore",
//   "Search",
//   "Profile",
// ];
//
// class _BottomBarItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isActive;
//   final VoidCallback onTap;
//
//   const _BottomBarItem({
//     required this.icon,
//     required this.label,
//     required this.isActive,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       behavior: HitTestBehavior.translucent,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 8,
//         ),
//         decoration: BoxDecoration(
//           color: isActive ? buttontheme : Colors.transparent,
//           borderRadius: BorderRadius.circular(18),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               size: 26,
//               color: isActive ? Colors.white : Colors.grey,
//             ),
//
//             AnimatedSize(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               child: isActive
//                   ? Padding(
//                 padding: const EdgeInsets.only(left: 8),
//                 child: Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//                   : const SizedBox(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Home"));
//   }
// }
//
// class ExploreScreen extends StatelessWidget {
//   const ExploreScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Explore"));
//   }
// }
//
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Search"));
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Profile"));
//   }
// }


import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'BottomScreens/Dashboard.dart';
import 'BottomScreens/EditListingcreen.dart';
import 'BottomScreens/ProfileScreen.dart';
import 'BottomScreens/SubscriptionScreen.dart';


class BottomController extends GetxController {
  var index = 0.obs;

  void changeTab(int i) {
    index.value = i;
  }
}

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({super.key});

  final BottomController controller = Get.put(BottomController());

  final pages = [
    DashboardScreen(),
    SubscriptionScreen(),
    EditListingScreen(),
    ProfileScreen(),
  ];

  final icons = [
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.edit_note_rounded,
    Icons.person
  ];

  final labels = [
    "Home",
    "Explore",
    "Edit",
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