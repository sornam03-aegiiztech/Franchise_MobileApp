import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../BottomBar.dart';



class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 20),

              /// Title
              const Text(
                "Notifications",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              /// Verification Icon
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: const Icon(
                  Icons.autorenew_rounded,
                  color: Colors.red,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              /// Heading
              const Text(
                "Verification In Progress",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// Description
              const Text(
                "Your documents have been received. Our team will review and activate your listing within 24 hours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 30),

              /// Status Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildStatusItem(true),
                    const SizedBox(height: 15),
                    _buildStatusItem(false),
                    const SizedBox(height: 15),
                    _buildStatusItem(false),
                  ],
                ),
              ),

              const Spacer(),

              /// Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Get.to(BottomBarScreen());
                  },
                  child: const Text(
                    "Go to BottomScreens",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Status Item
  Widget _buildStatusItem(bool isCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Documents submitted",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Received on oct 24, 02:30 PM",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}