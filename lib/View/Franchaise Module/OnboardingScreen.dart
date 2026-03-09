import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

import 'AuthModule/RegisterScreen.dart';




class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/onboarding1.png",
      "title": "Scale Your Franchise\n Presence",
      "desc": "Access verified leads and premium visibility \nwith our seamless management tools \ndesigned for professionals.",
    },
    {
      "image": "assets/images/onboarding2.png",
      "title": "Manage High-Quality Leads",
      "desc": "Track,Manageand respond to potential \nfranchise buyers with our intuitive lead \nmanagement system.",
    },
    {
      "image": "assets/images/onboarding3.png",
      "title": "Unlock Premium Growth",
      "desc": "Upgrade to publish your listing,access \nexclusive investor leads, and showcase your \nbrand with a verified badge.",
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
                                  Get.to(Registerscreen ());
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
                       Get.to(Registerscreen ());

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
