import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/View/Distribution%20Module/AuthModule/LoginScreen.dart';
import 'package:get/get.dart';

import 'AuthModule/RegisterScreen.dart';




class DistributionOnboardingScreen extends StatefulWidget {
  const DistributionOnboardingScreen({super.key});

  @override
  State<DistributionOnboardingScreen> createState() => _DistributionOnboardingScreenState();
}

class _DistributionOnboardingScreenState extends State<DistributionOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/distributoronboarding1.png",
      "title": "Register as Distributor",
      "desc": "Being your journey to global distribution.\ncomplete your profile to access our \nexclusive inventory and premium logistics \nnetwork.",
    },
    {
      "image": "assets/images/Distributoronboarding2.png",
      "title": "Showcase Products",
      "desc": "List your catalog and reach thousand of \nretailer searching for quality suppliers in you \nterritory.",
    },
    {
      "image": "assets/images/Distributoronboarding3.png",
      "title": "Get Customer Visibility",
      "desc": "Upgrade to a premium account to make your \nbusiness profile and start receiving inquiries \nfrom potential buyers.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme,
      body: Stack(
        children: [






          /// Onboarding content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 250.0),
                              child: InkWell(
                                onTap: (){
                                  Get.to(DistributionLoginscreen());
                                },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                      color: Color(0xff878787)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Image
                            Image.asset(
                              _pages[index]["image"]!,
                              height: 290,
                            ),
                            const SizedBox(height: 20),

                            // Title
                            Text(
                              _pages[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Description
                            Text(
                              _pages[index]["desc"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xffD9D9D9)
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// Buttons
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        if (_currentPage == _pages.length - 1) {
                       Get.to(DistributionLoginscreen());

                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(

                        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                        decoration: BoxDecoration(
                          color: buttontheme,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
