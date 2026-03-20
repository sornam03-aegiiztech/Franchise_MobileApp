


import 'package:flutter/material.dart';
import 'package:franchaise_app/Controllers/FranchiseModuleAuthControllers/SubscriptionController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SubscriptionScreen extends StatelessWidget {
 SubscriptionScreen({super.key});

  final FranchiseSubscriptionController subscriptionController=Get.put(FranchiseSubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: const Color(0xff1f1f1f),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Subscription",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Active Plan Card
            Obx(() => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffF23E46),
                    Color(0xff8C2429),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TOP SECTION
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "ACTIVE PLAN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// PLAN TYPE
                        Text(
                          "${subscriptionController.planType.value} Membership",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        /// PLAN NAME
                        Text(
                          subscriptionController.planName.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  /// BOTTOM SECTION
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "SUBSCRIPTION STATUS",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),

                        const SizedBox(height: 10),

                        /// INCLUDED FEATURES
                        ...subscriptionController.includedList.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text("• $e"),
                        )),

                        const SizedBox(height: 16),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffff4b4b),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Renew Now ₹${subscriptionController.planType.value}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),

            const SizedBox(height: 25),

            /// Billing History Title
            const Text(
              "Billing History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            /// Billing List
            Column(
              children: List.generate(
                3,
                    (index) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xff2c2c2c),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.receipt,
                            color: Colors.white),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "September 2024 Invoice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Sep 23,2025 - ₹199",
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.download,
                          color: Colors.white70)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}