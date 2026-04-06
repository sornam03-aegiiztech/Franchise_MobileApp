import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/utlity.dart';

import 'package:get/get.dart';

import '../../../Controllers/DistributorModuleController/SubscriptionController.dart';
import '../VerficationScreens/Notifications.dart';

class ActivateDistributionScreen extends StatelessWidget {
 ActivateDistributionScreen({super.key});

  final DistributorSubscriptionController subscriptionController=Get.put(DistributorSubscriptionController());


  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
     Scaffold(
        body: Stack(
          children: [

            /// BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(
                "assets/images/Backgroundimage.png",
                fit: BoxFit.cover,
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const SizedBox(height: 10),
                    Row(
                      children: [

                        InkWell(
                          onTap:(){
                            Get.back();
              },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),

                        const SizedBox(width: 50),

                        const Text(
                          "Activate Distributor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Ready To Publish Your \nDistributor Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Upgrade to premium to publish your\nlisting and start receiving high-quality\nleads",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 30),

                    /// PLAN CARD
                    Stack(
                      clipBehavior: Clip.none,
                      children: [

                        /// MAIN CARD
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),

                            border: Border.all(color: Colors.white24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [

                              /// PRICE
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Obx(() => Text(
                                    "₹${subscriptionController.planName.value}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                    ),
                                  )),

                                  SizedBox(width: 8),

                                  Text(
                                    "₹399",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                "Get Premium Lifetime Access",
                                style: TextStyle(color: Colors.white70),
                              )

                            ],
                          ),
                        ),

                        /// FULL WIDTH OFFER LABEL
                        Positioned(
                          top: -18,
                          left: 0,
                          right: 0,

                          child: Container(
                            height: 36,
                            alignment: Alignment.center,

                            decoration: const BoxDecoration(
                              color: Color(0xffFF4040),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),

                            child: Text(
                              subscriptionController.planType.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 30),

                    /// WHAT'S INCLUDED
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What's included",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    const SizedBox(height: 15),
                    Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: subscriptionController.includedList
                          .map((e) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "• $e",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                          .toList(),
                    )),


                    const SizedBox(height: 50),



                    /// PAY BUTTON
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF23E46),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const SuccessDialog(),
                          );
                        },
                        child:  Obx(() => Text(
                          "Pay Now ₹${subscriptionController.planName.value}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ))
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Recurring billing cancel anytime. By tapping Continue you agree to our Terms of Service.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white38,
                          fontSize: 12),
                    ),

                    const SizedBox(height: 20)
                  ],
                ),
              ),
            )
          ],
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

  Widget _feature(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check,color: Colors.white),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

/// SUCCESS POPUP
class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.check,
                  size: 40,
                  color: Colors.white),
            ),

            const SizedBox(height: 20),

            const Text(
              "Subscription Successful!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Welcome to the premium club, you now have Annual to publish your listing.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF4040),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Get.to(VerificationScreen());
                },
                child: const Text("Start Exploring",style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}