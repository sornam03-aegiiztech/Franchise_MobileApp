import 'package:flutter/material.dart';
import 'package:franchaise_app/View/Franchaise%20Module/AuthModule/LoginScreen.dart';
import 'package:franchaise_app/View/Franchaise%20Module/BottomScreens/SubscriptionScreen.dart';
import 'package:get/get.dart';

import '../../../Constants/Colors.dart';
import '../ProfileModule/EditProfileScreen.dart';



class DistributionProfileScreen extends StatelessWidget {
  const DistributionProfileScreen({super.key});

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
                  Center(
                    child: Column(
                      children: [

                        Stack(
                          children: [

                            const CircleAvatar(
                              radius: 48,
                              backgroundImage:
                              AssetImage("assets/images/profile.png"),
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
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Guhan",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "EcoClean Co.",
                          style: TextStyle(
                              color: Colors.white54),
                        )
                      ],
                    ),
                  ),

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
                      Get.to(ProfileEditScreen());
                    },
                      child: _menuTile(Icons.person_outline, "Edit Profile")),
                  const SizedBox(height: 12),
              InkWell(
                onTap: (){
                  Get.to(SubscriptionScreen());
                },
                  child: _menuTile(Icons.workspace_premium_outlined, "Subscription")),

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

                  _menuTile(Icons.language, "Choose language"),
                  const SizedBox(height: 12),
                  _menuTile(Icons.security_outlined, "Security"),
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
              onPressed: () {


                Get.offAll(Loginscreen());

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