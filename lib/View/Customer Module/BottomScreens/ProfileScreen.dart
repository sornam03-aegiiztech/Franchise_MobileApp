import 'package:flutter/material.dart';
import 'package:franchaise_app/ChoosejourneyScreen.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Controllers/CustomerModuleController/AuthController.dart';
import 'package:franchaise_app/View/Customer%20Module/AuthModule/LoginScreen.dart';
import 'package:franchaise_app/View/Customer%20Module/ProfileModule/FavouritesScreen.dart';
import 'package:franchaise_app/View/Customer%20Module/ProfileModule/PrivacyPolicy.dart';
import 'package:franchaise_app/View/Customer%20Module/ProfileModule/TermsandConditions.dart';
import 'package:get/get.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/ProfileController.dart';
import '../ProfileModule/EditProfileScreen.dart';









class CustomerProfileScreen extends StatefulWidget {
  CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final controller = Get.put(CustomerProfileController());

  @override
  void initState() {
    super.initState();
    controller.getProfile();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff2b2b2b),
              Color(0xff1f1f1f),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(   // ✅ SCROLL ADDED
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  /// Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Center(
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),


                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Profile Image
                  Obx(() => Center(
                    child: Column(
                      children: [

                        Stack(
                          children: [

                            CircleAvatar(
                              radius: 48,
                              backgroundImage: controller.profileImage.value.isNotEmpty
                                  ? NetworkImage(
                                  controller.profileImage.value.startsWith("http")
                                      ? controller.profileImage.value
                                      : "${AppConfig.imageURL}${controller.profileImage.value}"
                              )
                                  : const AssetImage("assets/images/profile.png") as ImageProvider,
                            ),

                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),

                        Text(
                          controller.fullName.value.isNotEmpty
                              ? controller.fullName.value
                              : "User",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 30),

                  /// Account Settings
                  const Text(
                    "Account Settings",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 14),

                  InkWell(
                    onTap: (){
                      Get.to(CustomerProfileEditScreen());
                    },
                      child: _menuTile(Icons.person_outline, "Edit Profile")),
                  const SizedBox(height: 12),
                  InkWell(
                      onTap: (){
                        Get.to(FavouritePage());
                      },
                      child: _menuTile(Icons.favorite_border, "Favorites")),

                  const SizedBox(height: 25),

                  /// Support & Legal
                  const Text(
                    "Support & Legal",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 14),

                  InkWell(
                    onTap: (){
                      Get.to(CustomerTermsScreen());
                    },
                      child: _menuTile(Icons.description, "Terms & Conditions")),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: (){
                      Get.to(CustomerPrivacyPolicyScreen());
                    },
                      child: _menuTile(Icons.security_outlined, "Privacy Policy")),
                  const SizedBox(height: 12),
                  _menuTile(Icons.help_outline, "Help & Support"),

                  const SizedBox(height: 40),

                  /// Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7a2c2c),
                        padding:
                        const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      icon: const Icon(Icons.power_settings_new,color: Color(0xffFF4A4A),),
                      label: const Text(
                        "Log Out",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,color: Color(0xffFF4A4A)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          backgroundColor: apptheme,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
          ),

          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.white70),
          ),

          actions: [

            /// CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),

            /// LOGOUT
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {

                await AppConfig.pref.clear(); // clear saved data

                Get.delete<CustomerLoginController>(); // reset controller

                Get.offAll(() => ChooseJourneyScreen());




              },
              child: const Text("Logout",style: TextStyle(color: Colors.white),),
            ),

          ],
        );
      },
    );
  }

  Widget _menuTile(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff3a3a3a),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15),
            ),
          ),

          const Icon(Icons.chevron_right,
              color: Colors.white54)
        ],
      ),
    );
  }
}