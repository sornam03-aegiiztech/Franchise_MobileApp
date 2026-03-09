import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/View/Franchaise%20Module/OnboardingScreen.dart';

import '../ChoosejourneyScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward(); // Start animation


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => ChooseJourneyScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: apptheme,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: Image.asset(
            "assets/images/applogo.png",
            width: screenWidth / 2,
          ),
        ),
      ),
    );
  }
}