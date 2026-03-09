import 'package:flutter/material.dart';
import 'package:franchaise_app/Constants/Colors.dart';

import '../DetailsPage/FranchiseDetailsPage.dart';



class AllFranchisePage extends StatefulWidget {
  const AllFranchisePage({super.key});

  @override
  State<AllFranchisePage> createState() => _AllFranchisePageState();
}

class _AllFranchisePageState extends State<AllFranchisePage> {

  int selectedTab = 0;

  List<String> tabs = ["All", "Food", "Retail", "Fashion"];

  List<Map<String, String>> franchises = [
    {
      "title": "EcoClean Solution",
      "investment": "250k - 500k Investment",
      "category": "Retail",
      "image": "https://images.unsplash.com/photo-1556911220-e15b29be8c8f"
    },
    {
      "title": "Coffee Hub",
      "investment": "150k - 350k Investment",
      "category": "Food",
      "image": "https://images.unsplash.com/photo-1509042239860-f550ce710b93"
    },
    {
      "title": "Fashion Store",
      "investment": "200k - 400k Investment",
      "category": "Fashion",
      "image": "https://images.unsplash.com/photo-1521334884684-d80222895322"
    },
  ];

  double dragPosition = 0;

  List<Map<String,String>> getFilteredList() {

    if(selectedTab == 0){
      return franchises;
    }

    String category = tabs[selectedTab];

    return franchises
        .where((item) => item["category"] == category)
        .toList();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    var filteredList = getFilteredList();

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
                        "All Franchise",
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

                      child: const Row(
                        children: [
                          Icon(Icons.search,color: Colors.white54),
                          SizedBox(width:10),
                          Text(
                            "Search franchises...",
                            style: TextStyle(color: Colors.white54),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: width * 0.03),

                  Container(
                    height: height * 0.06,
                    width: height * 0.06,

                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: const Icon(Icons.tune,color: Colors.white),
                  )

                ],
              ),

              SizedBox(height: height * 0.02),

              /// CATEGORY TABS
              SizedBox(
                height: height * 0.05,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,

                  itemBuilder: (context,index){

                    bool selected = selectedTab == index;

                    return GestureDetector(

                      onTap: (){
                        setState(() {
                          selectedTab = index;
                        });
                      },

                      child: Container(
                        margin: EdgeInsets.only(right: width * 0.03),

                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.008,
                        ),

                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.red
                              : Colors.white10,

                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.white70,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.02),

              /// FRANCHISE LIST
              Expanded(
                child: ListView.builder(

                  itemCount: filteredList.length,

                  itemBuilder: (context,index){

                    var data = filteredList[index];

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
                              child: Image.network(
                                data["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),

                            /// GRADIENT
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black87
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),

                            /// TEXT
                            Positioned(
                              left: width * 0.04,
                              bottom: height * 0.09,

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    data["title"]!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    data["investment"]!,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            /// SEE MORE BUTTON
                            Positioned(
                              left: 15,
                              bottom: 10,
                              child: StatefulBuilder(
                                builder: (context, setStateBtn) {
                                  return GestureDetector(

                                    onHorizontalDragUpdate: (details) {
                                      setStateBtn(() {
                                        dragPosition += details.delta.dx;

                                        if (dragPosition < 0)
                                          dragPosition = 0;
                                        if (dragPosition > 150)
                                          dragPosition = 150;
                                      });
                                    },

                                    onHorizontalDragEnd: (details) {
                                      if (dragPosition > 130) {

                                        /// NAVIGATE PAGE
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                                context) => const  FranchiseDetailsPage (),
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
                                        color: Colors.white.withOpacity(
                                            .25),
                                        borderRadius: BorderRadius.circular(
                                            30),
                                      ),

                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [

                                          const Center(
                                            child: Text(
                                              "See more",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          AnimatedPositioned(
                                            duration: const Duration(
                                                milliseconds: 100),
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
              )

            ],
          ),
        ),
      ),
    );
  }
}