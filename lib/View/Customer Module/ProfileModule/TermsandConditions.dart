import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class CustomerTermsScreen extends StatelessWidget {
  const CustomerTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
     Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Customer Terms & Conditions",
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
                  text:
                  "Welcome to the Franchice App (Customer Module).\n\n\n",
                ),

                // Section 1
                TextSpan(
                  text: "1. Platform Usage\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nCustomers can browse and view Franchise and Distributor listings available in the app.\n\n\n",
                ),

                // Section 2
                TextSpan(
                  text: "2. No Direct Orders\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nCustomers are not allowed to place orders through the platform.\n\n\n",
                ),

                // Section 3
                TextSpan(
                  text: "3. Subscription Requirement\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\n• Full details available only for subscribed users\n"
                      "• Non-subscribed users will have limited access\n\n\n",
                ),

                // Section 4
                TextSpan(
                  text: "4. Restricted Access\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\n• Full business details are restricted without subscription\n"
                      "• Owner contact access is restricted\n\n\n",
                ),

                // Section 5
                TextSpan(
                  text: "5. User Conduct\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nUsers must not misuse the platform or attempt unauthorized access.\n\n\n",
                ),

                // Section 6
                TextSpan(
                  text: "6. Account Control\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nViolation of rules may result in account suspension.\n\n\n",
                ),

                // Section 7
                TextSpan(
                  text: "7. Changes to Terms\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nTerms may be updated at any time without prior notice.\n",
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