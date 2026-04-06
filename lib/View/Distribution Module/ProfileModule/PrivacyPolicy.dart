import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class DistributorPrivacyPolicyScreen extends StatelessWidget {
  const DistributorPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
       Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Distributor Privacy Policy",
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
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: "Distributor Privacy Policy\n\n\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                // Section 1
                TextSpan(
                  text: "1. Information We Collect\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Personal details\n"),

                TextSpan(text: "• Work activity details\n\n\n"),

                // Section 2


                // Section 3


                // Section 4


                // Section 5
                TextSpan(
                  text: "2. Third-Party Sharing\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nData shared only with logistics and payment services.\n\n\n",
                ),

                // Section 6
                TextSpan(
                  text: "3. Updates\n",
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