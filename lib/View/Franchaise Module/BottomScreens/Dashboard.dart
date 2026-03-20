import 'package:flutter/material.dart';
import 'package:franchaise_app/Controllers/FranchiseModuleAuthControllers/DashboardController.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Controllers/FranchiseModuleAuthControllers/ProfileController.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final ListingController controller = Get.put(ListingController());
  final FranchiseDashboardController dashboardController=Get.put(FranchiseDashboardController());
  final profilecontroller = Get.put(FranchiseProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1C1C1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Top Profile Section
              Obx(() => Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: profilecontroller.profileImage.value.isNotEmpty
                        ? NetworkImage(profilecontroller.profileImage.value)
                        : const AssetImage("assets/images/profile.png")
                    as ImageProvider,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xff2C2C2E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none,
                        color: Colors.white),
                  )
                ],
              )),

              const SizedBox(height: 15),

              Obx(() => Text(
                "Welcome ${profilecontroller.ownerName.value},",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              )),

              const SizedBox(height: 5),

              const Text(
                "Publish your franchise and reach potential investors.",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 20),

              /// Listing Status Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "LISTING STATUS",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          letterSpacing: 1),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Currently Live",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Your Franchise listing is optimized and visible premium investors in the network.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 5),
                    const Text(
                      "Updated 2h ago",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// Toggle Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff2C2C2E),
                  borderRadius: BorderRadius.circular(20),
                ),
                  child:

                  Obx(
                        () =>
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Show listing to customer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Toggle off to hide from search results",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            Switch(
                              value: controller.showListing.value,
                              activeColor: Colors.red,
                              onChanged: (value) {
                                controller.toggleListing(value);
                              },
                            )
                          ],
                        ),
                  )
              ),

              const SizedBox(height: 15),

              /// Views Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff4EA3D7), Color(0xff295571)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() => Column(
                        children: [
                          const Icon(Icons.bar_chart, color: Colors.white),
                          const SizedBox(height: 10),
                          const Text("Total Content Views",
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 5),
                          Text(
                            dashboardController.totalContactView.value.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffA867E4), Color(0xff5D397E)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() => Column(
                        children: [
                          const Icon(Icons.remove_red_eye, color: Colors.white),
                          const SizedBox(height: 10),
                          const Text("Profile Views",
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 5),
                          Text(
                            dashboardController.profileView.value.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// Subscription Status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffF23E46), Color(0xffBF2329)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SUBSCRIPTION STATUS",
                        style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 10),
                    Text("Premium Active",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Colors.white30,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Text("3 Months remaining until renewal",
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListingController extends GetxController {
  var showListing = true.obs;

  void toggleListing(bool value) {
    showListing.value = value;
  }
}