import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Appconfig.dart';
import '../../../Controllers/CustomerModuleController/DashboardController.dart';
import '../../../main.dart';
import '../DetailsPage/DistributorsDetailsPage.dart';



class AllDistributorsPage extends StatefulWidget {
  const AllDistributorsPage({super.key});

  @override
  State<AllDistributorsPage> createState() => _AllDistributorsPageState();
}

class _AllDistributorsPageState extends State<AllDistributorsPage> {
  final controller = Get.put(ServicesController());
  final allcontroller = Get.put(AllDistributorController());
  TextEditingController searchController = TextEditingController();
  final favController = Get.put(FavouriteController());

  int selectedTab = 0;
  double dragPosition = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        allcontroller.loadMore();
      }
    });
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

              /// APP BAR
              Row(
                children: [



                  const Expanded(
                    child: Center(
                      child: Text(
                        "All Distributors",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      height: height * 0.06,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          allcontroller.getDistributor(
                            search: value,
                            category: allcontroller.selectedCategory.value,
                          );
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search distributors...",
                          hintStyle: TextStyle(color: Colors.white54),
                          prefixIcon: Icon(Icons.search, color: Colors.white54),
                        ),
                      ),
                    ),
                  ),



                ],
              ),

              SizedBox(height: height * 0.02),

              /// CATEGORY TABS
              Obx(() =>
                  SizedBox(
                    height: height * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.tabs.length,
                      itemBuilder: (context, index) {
                        bool selected = selectedTab == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                            allcontroller.getDistributor(
                              search: allcontroller.searchText.value,
                              category: controller.tabs[index],
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // 🔥 முக்கியம்
                            margin: EdgeInsets.only(right: width * 0.03),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: selected ? Colors.red : Colors.white10,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center( // 🔥 double ensure center
                              child: Text(
                                controller.tabs[index],
                                textAlign: TextAlign.center, // 🔥 text center
                                style: TextStyle(
                                  color: selected ? Colors.white : Colors
                                      .white70,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )),

              SizedBox(height: height * 0.02),

              /// FRANCHISE LIST
              Expanded(
                child: Obx(() {

                  /// 🔄 LOADING
                  if (allcontroller.isLoading.value) {
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

                  /// 🔥 REFRESH INDICATOR WRAP FULL
                  return RefreshIndicator(
                    onRefresh: () async {
                      searchController.clear();
                      await allcontroller.refreshData(); // 🔥 reset + reload
                    },
                    child: allcontroller.distributorList.isEmpty

                    /// ❌ EMPTY STATE → MUST BE SCROLLABLE
                        ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            "No distributors found",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    )

                    /// 🟢 DATA LIST
                        : ListView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: allcontroller.distributorList.length,
                      itemBuilder: (context, index) {

                        var data = allcontroller.distributorList[index];

                        return Container(
                          padding: EdgeInsets.all(8),
                          height: height * 0.45,
                          margin: EdgeInsets.only(bottom: height * 0.02),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [

                                /// IMAGE

                                Positioned.fill(
                                  child: (data["brand_logo"] != null &&
                                      data["brand_logo"].toString().isNotEmpty)
                                      ? Image.network(
                                    "${AppConfig.imageURL}${data["brand_logo"]}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/img.png", // ✅ default image
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                      : Image.asset(
                                    "assets/images/img.png", // ✅ default image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.black87,
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),

                                /// ❤️ ICON
                                Obx(() {
                                  bool isFav = favController.favouriteIds.contains(data["business_id"]);

                                  return Positioned(
                                    top: 12,
                                    right: 12,
                                    child: GestureDetector(
                                      onTap: () {
                                        bool isFav = favController.favouriteIds.contains(data["business_id"]);

                                        if (isFav) {

                                          favController.removeFavourite(
                                            businessId: data["business_id"],
                                            category: data["business_category"] ?? "",
                                            role: data["role"] ?? "",
                                          );
                                        } else {

                                          favController.addFavourite(
                                            businessId: data["business_id"],
                                            category: data["business_category"] ?? "",
                                            role: data["role"] ?? "",

                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          isFav ? Icons.favorite : Icons.favorite_border,
                                          color: isFav ? Colors.red : Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                                /// GRADIENT


                                /// TEXT
                                Positioned(
                                  left: width * 0.04,
                                  bottom: height * 0.09,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["brand_name"] ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${data["branch_territory_units"]} units",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// SEE MORE BUTTON (unchanged)
                                Positioned(
                                  left: 15,
                                  bottom: 10,
                                  child: StatefulBuilder(
                                    builder: (context, setStateBtn) {
                                      return GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          setStateBtn(() {
                                            dragPosition += details.delta.dx;

                                            if (dragPosition < 0) dragPosition = 0;
                                            if (dragPosition > 150) dragPosition = 150;
                                          });
                                        },
                                        onHorizontalDragEnd: (details) {
                                          if (dragPosition > 130) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                DistributorsDetailsPage(
                                                  type: data["role"] ?? "Distributor",
                                                  businessId: data["business_id"] ?? "",
                                                ),
                                              ),
                                            );
                                          }

                                          setStateBtn(() {
                                            dragPosition = 0;
                                          });
                                        },
                                        child: Container(
                                          width: 290,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.25),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              const Center(
                                                child: Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              AnimatedPositioned(
                                                duration:
                                                const Duration(milliseconds: 100),
                                                left: dragPosition,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
}