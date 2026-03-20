import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'Appconfig.dart';
import 'Controllers/FranchiseModuleAuthControllers/ProfileController.dart';
import 'View/Distribution Module/VerficationScreens/DistributorDetailsScreen.dart';
import 'View/SplashScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.init();
  HttpOverrides.global = DevHttpOverrides();
  configLoading();
  runApp(const MyApp());
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void configLoading() {
  EasyLoading.instance
    ..progressColor = Colors.black
    ..maskType = EasyLoadingMaskType.black
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 30.0
    ..radius = 20.0
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..maskColor = Colors.black.withOpacity(0.5)
    ..toastPosition = EasyLoadingToastPosition.center
    ..boxShadow = <BoxShadow>[];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Franchaise',
      theme: ThemeData(
        fontFamily: 'Outfit',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF002D62)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      builder: EasyLoading.init(),
      home: Splashscreen (),

    );
  }
}
