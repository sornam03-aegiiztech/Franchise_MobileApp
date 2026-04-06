import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:franchaise_app/Controllers/CustomerModuleController/DashboardController.dart';
import 'package:franchaise_app/View/Customer%20Module/DetailsPage/FranchiseDetailsPage.dart';
import 'package:get/get.dart';

import '../../../Appconfig.dart';
import '../../../main.dart';
import '../DetailsPage/DistributorsDetailsPage.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final controller=Get.put(GetFavouriteController());

  @override
  void initState() {
    super.initState();
    controller.getFavourites(); // 🔥 API call
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: apptheme,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },

                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 15,),
                      ),
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    "Favorites",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(width:40)

                ],
              ),

              SizedBox(height: height * 0.02),

              // /// SEARCH BAR
              // Row(
              //   children: [
              //
              //     Expanded(
              //       child: Container(
              //         height: 50,
              //         padding: const EdgeInsets.symmetric(horizontal: 15),
              //
              //         decoration: BoxDecoration(
              //           color: Colors.white10,
              //           borderRadius: BorderRadius.circular(30),
              //         ),
              //
              //         child:TextFormField(
              //           style: const TextStyle(color: Colors.white),
              //
              //           onChanged: (value) {
              //             controller.onSearch(value); // 🔥 API CALL
              //           },
              //
              //           decoration: InputDecoration(
              //             border: InputBorder.none,
              //             hintText: "Search favorite...",
              //             hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
              //             contentPadding: EdgeInsets.symmetric(vertical: 12),
              //
              //             prefixIcon: const Icon(
              //               Icons.search,
              //               color: Colors.white54,
              //               size: 16,
              //             ),
              //
              //             suffixIcon: IconButton(
              //               icon: const Icon(Icons.close, color: Colors.white54, size: 16),
              //               onPressed: () {
              //                 controller.clearSearch(); // 🔥 CLEAR SEARCH
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //
              //     const SizedBox(width: 10),
              //
              //     GestureDetector(
              //       onTap: () {
              //         Get.dialog(
              //           FilterDialog(),
              //         );
              //       },
              //       child: Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           color: Colors.white10,
              //           borderRadius: BorderRadius.circular(25),
              //         ),
              //         child: const Icon(Icons.tune, color: Colors.white),
              //       ),
              //     )
              //
              //   ],
              // ),
              //
              // SizedBox(height: height * 0.02),
              //
              // Obx(() => Text(
              //   "${controller.favouriteList.length} Results Found",
              //   style: const TextStyle(color: Colors.white70),
              // )),
              SizedBox(height: height * 0.02),

              /// RESULT LIST
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshData, // 🔥 IMPORTANT

                  child: Obx(() {

                    /// 🔥 First Loading
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

                    /// 🔥 Empty State
                    if (controller.favouriteList.isEmpty) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),

                            child: SizedBox(
                              height: constraints.maxHeight,

                              child: const Center(
                                child: Text(
                                  "No Favourites Found",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {

                        /// 🔥 SCROLL END → LOAD MORE
                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                          controller.loadMore();
                        }

                        return true;
                      },

                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(), // 🔥 IMPORTANT

                        itemCount: controller.favouriteList.length +
                            (controller.isPaginationLoading.value ? 1 : 0),

                        itemBuilder: (context, index) {

                          /// 🔥 Bottom Loader
                          if (index == controller.favouriteList.length) {
                            return const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final item = controller.favouriteList[index];
                          final details = item['details'] ?? {};
                          final role = item['business_role'] ?? "";
                          final businessId = details['business_id']?.toString() ?? "";// 🔥 IMPORTANT

                          String title = "";
                          String subtitle = "";
                          String image = "";
                          String category = details['business_category'] ?? "";

                          if (role == "Franchise") {
                            title = details['business_name'] ?? "";
                            subtitle = "₹${details['total_invesment'] ?? ""}";
                            image = details['image'] ?? "";
                          } else if (role == "Distributor") {
                            title = details['brand_name'] ?? "";
                            subtitle = "${details['branch_territory_units'] ?? ""} units";
                            image = details['brand_logo'] ?? "";
                          }

                          final imageUrl = image.isNotEmpty
                              ? "${AppConfig.imageURL}$image"
                              : "";

                          return resultCard(
                            title: title,
                            subtitle: subtitle,
                            category: category,
                            image: imageUrl,
                            businessId: businessId, role: role,
                          );
                        },
                      ),
                    );
                  }),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  /// CARD WIDGET
  Widget resultCard({
    required String title,
    required String subtitle,
    required String category,
    required String image,
    required String role,
    required String businessId,
  }){

    return Stack(
      children: [

        /// MAIN CARD
        Container(

          margin: const EdgeInsets.only(bottom:15),
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TEXT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height:4),

                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12),
                        ),

                        const SizedBox(height:10),

                        Text(
                          category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12),
                        )

                      ],
                    ),
                  ),

                  const SizedBox(width:10),

                  /// IMAGE
                  Stack(
                    children: [

                      /// IMAGE
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            image, // 👈 already full URL

                            height: 70,
                            width: 80,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/no_image.png", // ✅ LOCAL IMAGE
                                height: 70,
                                width: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        ),
                      ),



                    ],
                  )

                ],
              ),

              const SizedBox(height:15),

              /// BUTTON
              GestureDetector(
                onTap: () {
                  if (role == "Distributor") {
                    Get.to(() => DistributorsDetailsPage(
                      type: "Distributor", // ✅ proper value
                      businessId: businessId,
                    ));
                  } else if (role == "Franchise") {
                    Get.to(() => FranchiseDetailsPage(
                      type: "Franchise",
                      businessId: businessId,
                    ));
                  } else {
                    EasyLoading.showError("Invalid role");
                  }
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: buttontheme,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),

        /// SAVE ICON (CARD TOP RIGHT)
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(12),

            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
              size:14,
            ),
          ),
        ),

      ],
    );
  }
}


class FilterDialog extends StatelessWidget {

  final serviceController = Get.put(ServicesController());
  final dashboardController = Get.find<AllServicesController>();

  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              "Select Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// 🔥 COLUMN LIST
            Obx(() => ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300, // 🔥 max height
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    serviceController.tabs.length,
                        (index) {

                      final item = serviceController.tabs[index];

                      return GestureDetector(
                        onTap: () {

                          dashboardController.selectedCategory.value =
                          item == "All" ? "" : item;

                          dashboardController.getServices(
                            search: dashboardController.searchText.value,
                            category: dashboardController.selectedCategory.value,
                          );

                          Get.back();
                        },

                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )),

            const SizedBox(height: 10),

            /// CLOSE BUTTON
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}