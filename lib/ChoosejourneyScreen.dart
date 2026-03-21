import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/View/Customer%20Module/OnboardingScreen.dart';
import 'package:franchaise_app/View/Distribution%20Module/AuthModule/LoginScreen.dart';
import 'package:franchaise_app/View/Franchaise%20Module/AuthModule/LoginScreen.dart';
import 'package:franchaise_app/View/Franchaise%20Module/OnboardingScreen.dart';

import 'Appconfig.dart';
import 'View/Distribution Module/OnboardingScreen.dart';

class ChooseJourneyScreen extends StatelessWidget {
  const ChooseJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            children: [

              SizedBox(height: height * 0.03),

              /// TITLE
              const Text(
                "Choose Your Journey",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              const Text(
                "Select the role that best describes\nyour business goals today.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14),
              ),

              SizedBox(height: height * 0.04),

              /// CUSTOMER CARD
              _journeyCard(
                icon: Icons.person,
                title: "I am a customer",
                description:
                "Discover and connect with top-rated franchise bear you find your next favorite brand.",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>CustomerOnboardingScreen()),
                  );
                },
              ),

              SizedBox(height: height * 0.025),

              /// OWNER CARD
              _journeyCard(
                icon: Icons.business,
                title: "I am an Owner",
                description:
                "Scale your business and list your franchise on our premium marketplace.",
                onTap: () {
                  String token = AppConfig.pref.getString("token") ?? "";

                  if (token.isNotEmpty) {
                    // ✅ Already logged in → go to next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Loginscreen()), // or DashboardScreen()
                    );
                  } else {
                    // ❌ No token → go to onboarding
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OnboardingScreen()),
                    );
                  }
                },
              ),

              SizedBox(height: height * 0.025),

              /// DISTRIBUTOR CARD
              _journeyCard(
                icon: Icons.hub,
                title: "I am a Distributor",
                description:
                "Manage logistics and supply chains through our dedicated high-performance portal.",
                onTap: () {
                  String token = AppConfig.pref.getString("token") ?? "";

                  if (token.isNotEmpty) {
                    // ✅ Already logged in → go to next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DistributionLoginscreen()),
                    );
                  } else {
                    // ❌ No token → go to onboarding
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DistributionOnboardingScreen()),
                    );
                  }
                },
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  /// CARD WIDGET
  Widget _journeyCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ICON BOX
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff3A3A3A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,color: Colors.white),
          ),

          const SizedBox(height: 16),

          /// TITLE
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(
            description,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 13),
          ),

          const SizedBox(height: 20),

          /// BUTTON
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: buttontheme,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}