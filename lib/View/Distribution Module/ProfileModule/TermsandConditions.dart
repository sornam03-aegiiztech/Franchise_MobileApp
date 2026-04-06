import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class DistributorTermsScreen extends StatelessWidget {
  const DistributorTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
      Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Distributor Terms & Conditions",
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
                  "Welcome to the Franchice App (Distributor Module).\n\n\n",
                ),

                // Section 1
                TextSpan(
                  text: "1. Agreement\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nBy using this module, you agree to follow all platform rules and policies.\n\n\n",
                ),

                // Section 2
                TextSpan(
                  text: "2. Distributor Responsibilities\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Ensure timely delivery of products\n"),
                TextSpan(text: "• Maintain accurate stock records\n"),
                TextSpan(text: "• Operate within assigned areas\n\n\n"),

                // Section 3


                // Section 4
                TextSpan(
                  text: "3. Prohibited Activities\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Unauthorized product handling\n"),
                TextSpan(text: "• Misuse of platform services\n"),
                TextSpan(text: "• Fraudulent activities\n\n\n"),

                // Section 5


                // Section 6
                TextSpan(
                  text: "4. Changes to Terms\n",
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