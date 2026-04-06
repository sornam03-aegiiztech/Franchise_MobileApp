import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/DashboardController.dart';
import '../DetailsPage/DistributorsDetailsPage.dart';
import '../DetailsPage/FranchiseDetailsPage.dart';

class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({super.key});

  @override
  State<SearchFilterPage> createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  final controller = Get.put(AllServicesController());

  @override
  void initState() {
    super.initState();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [





                  const Text(
                    "Search & Filter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),





                ],
              ),

              SizedBox(height: height * 0.02),

              /// SEARCH BAR
              Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),

                        onChanged: (value) {
                          controller.searchText.value = value;

                          controller.getServices(
                            search: value,
                            category: controller.selectedCategory.value,
                          );
                        },

                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search ...",
                          hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                          contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 8),

                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white54,
                            size: 16,
                          ),

                          suffixIcon: Icon(
                            Icons.close,
                            color: Colors.white54,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        FilterDialog(),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(Icons.tune, color: Colors.white),
                    ),
                  )

                ],
              ),

              SizedBox(height: height * 0.02),

              Obx(() => Text(
                "${controller.services.length} Results Found",
                style: TextStyle(color: Colors.white70),
              )),

              SizedBox(height: height * 0.02),

              /// RESULT LIST
              Expanded(
                child: Obx(() {


                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.refreshData();
                    },
                    child: controller.services.isEmpty
                        ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            "No services found",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    )
                        : NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {

                        if (scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {

                          controller.getServices(
                            search: controller.searchText.value,
                            category: controller.selectedCategory.value,
                            loadMore: true,
                          );
                        }

                        return false;
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.services.length,
                        itemBuilder: (context, index) {

                          final data = controller.services[index];

                          return resultCard(
                            title: data["brand_name"] ?? "",
                            subtitle: data["name"] ?? "",
                            category: data["business_category"] ?? "",
                            image: "${AppConfig.imageURL}${data["image"] ?? ""}",
                            data: data,
                          );
                        },
                      ),
                    ),
                  );
                }),
              )

            ],
          ),
        ),
      ),
    );
  }

  /// RESULT CARD
  Widget resultCard({
    required String title,
    required String subtitle,
    required String category,
    required String image,
    required Map data,

  }){

    String extraText = "";

    if(data["type"] == "franchise"){
      extraText = "Investment: ₹ ${data["total_invesment"] ?? "N/A"}";
    }else{
      extraText = "Units: ${data["branch_territory_units"] ?? "N/A"}";
    }

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

                        const SizedBox(height:4),

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

                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child:image.isNotEmpty
                              ? Image.network(
                            image,
                            height: 70,
                            width: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/img.png",
                                height: 70,
                                width: 80,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                              : Image.asset(
                            "assets/images/img.png",
                            height: 70,
                            width: 80,
                            fit: BoxFit.cover,
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
                  String type = data["type"] == "franchise"
                      ? "Franchise"
                      : "Distributor";

                  String businessId = data["business_id"]?.toString() ?? "";

                  if (type == "Distributor") {
                    Get.to(() => DistributorsDetailsPage(
                      type: type,
                      businessId: businessId,
                    ));
                  } else {
                    Get.to(() => FranchiseDetailsPage(
                      type: type,
                      businessId: businessId,
                    ));
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