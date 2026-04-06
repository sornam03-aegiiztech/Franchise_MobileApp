import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/utlity.dart';
import 'package:get/get.dart';

import '../../../Controllers/FranchiseModuleAuthControllers/VerificationController.dart';
import '../BottomBar.dart';



class VerificationScreen extends StatelessWidget {
   VerificationScreen({super.key});

  final controller = Get.put(VerificationController());

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
     Scaffold(
        backgroundColor: const Color(0xFF1C1C1E),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.getVerification();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const SizedBox(height: 20),

                    /// Title
                    const Text(
                      "Notifications",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// Verification Icon
                    Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const Icon(
                        Icons.autorenew_rounded,
                        color: Colors.red,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Heading
                    const Text(
                      "Verification In Progress",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Description
                    const Text(
                      "Your documents have been received. Our team will review and activate your listing within 24 hours.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Status Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Obx(() {
                            if (controller.isLoading.value) {
                              return const CircularProgressIndicator(color: Colors.white);
                            }

                            return Column(
                              children: [
                                _buildStepItem(
                                  title: "General Verification",
                                  isCompleted: controller.generalStatus.value == "Approved",
                                  isLast: false,
                                ),

                                _buildStepItem(
                                  title: "Financials Verification",
                                  isCompleted: controller.contactStatus.value == "Approved",
                                  isLast: false,
                                ),

                                _buildStepItem(
                                  title: "Final Verification",
                                  isCompleted: controller.verificationStatus.value == "Approved",
                                  isLast: true,
                                ),
                              ],
                            );
                          })
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// Button
                    Obx(() {
                      bool isAllApproved =
                          controller.generalStatus.value.toLowerCase() == "approved" &&
                              controller.contactStatus.value.toLowerCase() == "approved" &&
                              controller.verificationStatus.value.toLowerCase() == "approved";

                      return SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            isAllApproved ? const Color(0xFFFF3B30) : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          /// 🔥 BUTTON ENABLE / DISABLE
                          onPressed: isAllApproved
                              ? () {
                            Get.offAll(() => BottomBarScreen());
                          }
                              : null,

                          child: Text(
                            isAllApproved
                                ? "Go to BottomScreens"
                                : "Waiting for Approval...",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => this),
        );
      },
    );
  }

  /// Status Item
   Widget _buildStepItem({
     required String title,
     required bool isCompleted,
     required bool isLast,
   }) {
     return Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Column(
           children: [
             /// Circle
             Container(
               width: 20,
               height: 20,
               decoration: BoxDecoration(
                 color: isCompleted ? Colors.green : Colors.grey,
                 shape: BoxShape.circle,
               ),
               child: Icon(
                 isCompleted ? Icons.check : Icons.access_time,
                 size: 12,
                 color: Colors.white,
               ),
             ),

             /// Line
             if (!isLast)
               Container(
                 width: 2,
                 height: 40,
                 color: Colors.grey,
               ),
           ],
         ),

         const SizedBox(width: 12),

         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               title,
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
               ),
             ),
             const SizedBox(height: 4),
             Text(
               isCompleted ? "Approved" : "Pending",
               style: const TextStyle(
                 color: Colors.white60,
                 fontSize: 12,
               ),
             ),
           ],
         ),
       ],
     );
   }
}