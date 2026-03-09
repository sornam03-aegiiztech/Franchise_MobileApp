import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

import '../Subscriptions/PremiumScreen.dart';

class DistributorsDetailsPage extends StatelessWidget {
  const DistributorsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// IMAGE HEADER
            Stack(
              children: [

                SizedBox(
                  height: height * 0.45,
                  width: double.infinity,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da",
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),



                        const Spacer(),

                        const Text(
                          "Franchise Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        const SizedBox(width:40)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(.4),
                     shape: BoxShape.circle
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),

              ],
            ),

            /// MAIN CONTENT
            Container(
              width: width,
              padding: EdgeInsets.all(width * 0.05),

              decoration: const BoxDecoration(
                color: Color(0xff2A2A2A),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// HEADER CARD
                  Row(
                    children: [

                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.store,color: Colors.black),
                      ),

                      const SizedBox(width:12),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Luxe Goods",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Luxury Retails Distributor Ltd",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),

                        ],
                      )
                    ],
                  ),

                  const SizedBox(height:20),

                  const Text(
                    "Minimum Order",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height:4),

                  const Text(
                    "500+ Units",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:15),

                  const Text(
                    "Years Active",
                    style: TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height:4),

                  const Text(
                    "12+ years",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:20),

                  const Text(
                    "About Distributors",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:8),

                  const Text(
                    "Premier wholesale distributor specializing in high-quality fruit juices, concentrates, and premium carbonates beverages.",
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height:20),

                  const Text(
                    "Product Handled",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height:10),

                  const Row(
                    children: [
                      Icon(Icons.check,color: Colors.white70,size:18),
                      SizedBox(width:8),
                      Text("Soap",style: TextStyle(color: Colors.white70))
                    ],
                  ),

                  const SizedBox(height:6),

                  const Row(
                    children: [
                      Icon(Icons.check,color: Colors.white70,size:18),
                      SizedBox(width:8),
                      Text("Serum",style: TextStyle(color: Colors.white70))
                    ],
                  ),

                  const SizedBox(height:6),

                  const Row(
                    children: [
                      Icon(Icons.check,color: Colors.white70,size:18),
                      SizedBox(width:8),
                      Text("Sunscreen",style: TextStyle(color: Colors.white70))
                    ],
                  ),

                  const SizedBox(height:30),

                  /// CONTACT BUTTON
                  InkWell(
                    onTap: (){
                      Get.to(Premiumscreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,

                      decoration: BoxDecoration(
                        color: buttontheme,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock,color: Colors.white,size: 16,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Contact Owner",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}