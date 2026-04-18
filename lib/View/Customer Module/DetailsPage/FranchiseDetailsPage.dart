import 'package:flutter/material.dart';
import 'package:franchaise_app/Appconfig.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/View/Customer%20Module/Contact/FranchiseContact.dart';
import 'package:get/get.dart';

import '../../../Controllers/CustomerModuleController/DashboardController.dart';
import '../../../main.dart';
import '../Subscriptions/PremiumScreen.dart';

class FranchiseDetailsPage extends StatefulWidget {
  final String type;
  final String businessId;
  const FranchiseDetailsPage({super.key, required this.type, required this.businessId});

  @override
  State<FranchiseDetailsPage> createState() => _FranchiseDetailsPageState();
}

class _FranchiseDetailsPageState extends State<FranchiseDetailsPage> {
  final controller = Get.put(FranchiseDetailsController());
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();

    controller.fetchFranchiseDetails(
      type: widget.type,
      businessId: widget.businessId,
      viewType: "profile",
    );
  }





  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:Color(0xff2A2A2A),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FoldingCubeWidget(size: 60),
                SizedBox(height: 15),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          );
        }

        final data = controller.details.value;


        if (data == null) {
          return Center(child: Text("No Data"));
        }
        /// ✅ FIXED BENEFITS LOGIC
        List<String> benefits = [];

        if (data.keyBenefits.isNotEmpty) {
          benefits = data.keyBenefits
              .replaceAll('"', '')
              .split(',')
              .map((e) => e.trim())
              .toList();
        }
        return SingleChildScrollView(
          child: Column(
            children: [

              /// IMAGE HEADER
              Stack(
                children: [

                  SizedBox(
                    height: height * 0.45,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: controller.details.value?.images?.length ?? 0,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final image = controller.details.value?.images?[index] ?? "";

                        return Image.network(
                          "${AppConfig.imageURL}$image",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/img.png",
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ),
                  ),

                  /// 🔵 DOT INDICATOR
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.details.value?.images?.length ?? 0,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: currentIndex == index ? 10 : 6,
                          height: currentIndex == index ? 10 : 6,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.white54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),


                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),


                          const Spacer(),

                          const Text(
                            "Franchise Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          const SizedBox(width: 40)
                        ],
                      ),
                    ),
                  ),


                ],
              ),

              /// MAIN CONTENT
              Container(
                width: width,

                padding: EdgeInsets.all(width * 0.05),

                decoration: const BoxDecoration(
                  color: Color(0xff2A2A2A),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HEADER CARD
                    Row(
                      children: [

                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: (data.ownerImage.isNotEmpty)
                                ? Image.network(
                              "${AppConfig.imageURL}${data.ownerImage}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, color: Colors.black);
                              },
                            )
                                : const Icon(Icons.person, color: Colors.black),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              data?.brandname ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                             data?.category ?? "",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Total Invesment",
                      style: TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "₹${data?.investment ?? ""}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        statCard(Icons.home, "Units", data.units),

                        statCard(Icons.public, "Regions", data.regions),

                        statCard(Icons.access_time, "Term", data.term),

                      ],
                    ),


                    const SizedBox(height: 20),

                    const Text(
                      "About",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      data?.description ?? "",
                      style: TextStyle(
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Key Benefits",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Column(
                      children: benefits.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.check, color: Colors.red, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 30),

                    const SizedBox(height:30),

                    /// CONTACT BUTTON
                    InkWell(
                      onTap: () {
                        Get.to(FranchiseContactPage(
                          type: widget.type,
                          businessId: widget.businessId,)
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 55,

                        decoration: BoxDecoration(
                          color: buttontheme,
                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock, color: Colors.white, size: 16,),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Contact Owner",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              )

            ],
          ),
        );
      }
      ),
    );
  }

  /// STAT CARD
  Widget statCard(IconData icon,String title,String value){
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [

          Icon(icon,color: Colors.white70,size:18),

          const SizedBox(height:5),

          Text(title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              )),

          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ))

        ],
      ),
    );
  }
}