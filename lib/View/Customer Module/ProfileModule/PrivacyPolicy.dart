import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class CustomerPrivacyPolicyScreen extends StatelessWidget {
  const CustomerPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
      Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Customer Privacy Policy",
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
                height: 1.6,
              ),
              children: [
                TextSpan(
                  text: "Customer Privacy Policy\n\n\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                // Section 1
                TextSpan(
                  text: "1. Information We Collect\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Name and phone number\n"),
                TextSpan(text: "• Basic profile details\n"),
                TextSpan(text: "• App usage data\n\n\n"),

                // Section 2
                TextSpan(
                  text: "2. How We Use Data\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• To show Franchise and Distributor listings\n"),
                TextSpan(text: "• To manage subscription access\n"),
                TextSpan(text: "• To improve user experience\n\n\n"),

                // Section 3
                TextSpan(
                  text: "3. Subscription Data\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nSubscription status is used to control access to detailed information.\n\n\n",
                ),

                // Section 4
                TextSpan(
                  text: "4. Restricted Data Access\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Full details shown only for subscribed users\n"),
                TextSpan(text: "• Owner contact details are restricted\n\n\n"),

                // Section 5
                TextSpan(
                  text: "5. Data Protection\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nWe ensure your data is securely stored and protected.\n\n\n",
                ),

                // Section 6
                TextSpan(
                  text: "6. Third-Party Sharing\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nData is shared only for essential services like payments.\n\n\n",
                ),

                // Section 7
                TextSpan(
                  text: "7. Updates\n",
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