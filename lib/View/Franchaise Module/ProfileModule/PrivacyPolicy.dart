import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class FranchisePrivacyPolicyScreen extends StatelessWidget {
  const FranchisePrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
      Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Franchise Privacy Policy",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                height: 1.4, // 🔥 line spacing
              ),
              children: [
                TextSpan(
                  text: "Franchise Privacy Policy\n\n\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                // Section 1
                TextSpan(
                  text: "1. Information We Collect\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Business details\n"),
                TextSpan(text: "• Contact information\n"),


                // Section 2
                TextSpan(
                  text: "2. How We Use Data\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• To manage franchise operations\n"),
                TextSpan(text: "• To process payments\n"),
                TextSpan(text: "• To improve services\n\n\n"),

                // Section 3
                TextSpan(
                  text: "3. Data Protection\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nWe implement strong security measures to protect your data.\n\n\n",
                ),

                // Section 4


                // Section 5
                TextSpan(
                  text: "4. Updates\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nPolicy may change anytime. Continued use means acceptance.\n",
                ),
              ],
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
}