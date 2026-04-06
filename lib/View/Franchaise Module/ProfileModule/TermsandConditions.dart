import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Constants/utlity.dart';

class FranchiseTermsScreen extends StatelessWidget {
  const FranchiseTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Utility.checkInternetManagerWidget(
       Scaffold(
        backgroundColor: apptheme,
        appBar: AppBar(
          backgroundColor: apptheme,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Franchise Terms & Conditions",
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
                height: 1.2, // 🔥 line spacing
              ),
              children: [
                TextSpan(
                  text:
                  "Welcome to the Franchice App (Franchise Module).\n\n\n",
                ),

                // Heading 1
                TextSpan(
                  text: "1. Acceptance of Terms\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text:
                  "\nBy accessing this module, you agree to comply with all terms and policies.\n\n\n",
                ),

                // Heading 2
                TextSpan(
                  text: "2. Franchise Responsibilities\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Maintain accurate business information\n"),
                TextSpan(text: "• Ensure product/service quality\n"),
                TextSpan(text: "• Follow platform pricing and policies\n\n\n"),

                // Heading 3
                TextSpan(
                  text: "3. Payments & Commissions\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: "\n• All transactions are processed securely\n\n\n",
                ),

                // Heading 4
                TextSpan(
                  text: "4. Prohibited Activities\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "\n• Fraudulent transactions\n"),
                TextSpan(text: "• Misuse of customer data\n"),
                TextSpan(text: "• Violation of legal regulations\n\n\n"),

                // Heading 5
                TextSpan(
                  text: "5. Changes to Terms\n",
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