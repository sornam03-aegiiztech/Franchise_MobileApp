import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

import 'AuthModule/RegisterScreen.dart';






class CustomerOnboardingScreen extends StatefulWidget {
  const CustomerOnboardingScreen({super.key});

  @override
  State<CustomerOnboardingScreen> createState() => _CustomerOnboardingScreenState();
}

class _CustomerOnboardingScreenState extends State<CustomerOnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/customeronboard1.png",
      "title": "Discover Top Franchise",
      "desc": "Explore a curated list of  high-growth \nfranchise opprtunities across various \nindustries.",
    },
    {
      "image": "assets/images/customeronboard2.png",
      "title": "Compare Options",
      "desc": "Analyze ranges, ROI potential, and \nrequirements to find your perfect match.",
    },
    {
      "image": "assets/images/customeronboard3.png",
      "title": "Connect Easily",
      "desc": "Subscribe for a nominal fee to get direct \naccess to franchise owners contact details",
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
                                  Get.to(CustomerRegisterscreen ());
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
                       Get.to(CustomerRegisterscreen());

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
