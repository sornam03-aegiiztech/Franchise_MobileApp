import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../../Appconfig.dart';



class CustomerDashboardController extends GetxController {

  var isLoading = false.obs;

  var franchises = [].obs;
  var distributors = [].obs;

  var searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    getDashboard();
  }

  Future<void> getDashboard({String search = ""}) async {
    searchText.value = search;
    if(search.isEmpty){
      /// default load
      print("DEFAULT LOAD");
    } else {
      print("SEARCH → $search");
    }
    try {
      isLoading(true);

      franchises.clear();
      distributors.clear();


      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}customer_dashboard_service?search=$search"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      final data = jsonDecode(response.body);


      if (data["status"] == 200) {

        if(search.isNotEmpty){
          EasyLoading.dismiss(); // stop previous
        }


        // franchises.value = data["data"]["franchises"] ?? [];
        // distributors.value = data["data"]["distributors"] ?? [];

        franchises.assignAll(data["data"]["franchises"] ?? []);
        distributors.assignAll(data["data"]["distributors"] ?? []);

      } else {
        franchises.clear();
        distributors.clear();
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      franchises.clear();
      distributors.clear();
      EasyLoading.showError("Error");
    } finally {
      isLoading(false);
    }
  }
}

class ServicesController extends GetxController {

  var tabs = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getServices();
  }

  Future<void> getServices() async {
    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}services_list"),
      );

      final data = jsonDecode(response.body);




      if (data["status"] == 200) {
        List list = data["data"];

        tabs.clear();
        tabs.add("All");

        for (var item in list) {
          tabs.add(item["service_name"]);
        }
      }

    } catch (e) {
      EasyLoading.showError("Error");
    } finally {
      isLoading(false);
    }
  }
}


class AllFranchiseController extends GetxController {

  /// ---------------- LOADING ----------------
  var isLoading = false.obs;
  var isPaginationLoading = false.obs;

  /// ---------------- DATA ----------------
  var franchiseList = [].obs;

  /// ---------------- SEARCH & FILTER ----------------
  var searchText = "".obs;
  var selectedCategory = "".obs;

  /// ---------------- PAGINATION ----------------
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getFranchises();
  }

  /// ---------------- GET FRANCHISES ----------------
  Future<void> getFranchises({
    String search = "",
    String category = "",
    bool isLoadMore = false,
  }) async {
    try {

      /// 🔥 LOAD TYPE
      if (isLoadMore) {
        isPaginationLoading(true);
      } else {
        isLoading(true);
        currentPage.value = 1;
        franchiseList.clear();
      }

      /// 🔥 STORE FILTER VALUES
      searchText.value = search;
      selectedCategory.value = category;

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseURL}all_franchises?page=${currentPage.value}&search=$search&category=$category",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      final data = jsonDecode(response.body);

      print("FRANCHISE RESPONSE → $data");

      if (data["status"] == 200) {

        var responseData = data["data"];


        currentPage.value = responseData["current_page"] ?? 1;
        lastPage.value = responseData["last_page"] ?? 1;

        List newData = responseData["data"] ?? [];


        if (isLoadMore) {
          franchiseList.addAll(newData);
        } else {
          franchiseList.assignAll(newData);
        }

      } else if (data["status"] == 404) {

        if (!isLoadMore) {
          franchiseList.clear();
        }

        EasyLoading.showError(data["message"]); // "No franchises found"

      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      print("ERROR → $e");
      EasyLoading.showError("Something went wrong");
    } finally {
      isLoading(false);
      isPaginationLoading(false);
    }
  }

  /// ---------------- LOAD MORE ----------------
  void loadMore() {

    if (currentPage.value < lastPage.value &&
        !isPaginationLoading.value) {

      currentPage.value++;

      getFranchises(
        search: searchText.value,
        category: selectedCategory.value,
        isLoadMore: true,
      );
    }
  }

  /// ---------------- REFRESH ----------------
  Future<void> refreshData() async {
    currentPage.value = 1;

    await getFranchises(
      search: "",
      category: "",
      isLoadMore: false,
    );
  }
}


class AllDistributorController extends GetxController {

  /// ---------------- LOADING ----------------
  var isLoading = false.obs;
  var isPaginationLoading = false.obs;

  /// ---------------- DATA ----------------
  var distributorList = [].obs;

  /// ---------------- SEARCH & FILTER ----------------
  var searchText = "".obs;
  var selectedCategory = "".obs;

  /// ---------------- PAGINATION ----------------
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getDistributor();
  }

  /// ---------------- GET FRANCHISES ----------------
  Future<void> getDistributor({
    String search = "",
    String category = "",
    bool isLoadMore = false,
  }) async {
    try {

      /// 🔥 LOAD TYPE
      if (isLoadMore) {
        isPaginationLoading(true);
      } else {
        isLoading(true);
        currentPage.value = 1;
       distributorList.clear();
      }

      /// 🔥 STORE FILTER VALUES
      searchText.value = search;
      selectedCategory.value = category;

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseURL}all_distributor?page=${currentPage.value}&search=$search&category=$category",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      final data = jsonDecode(response.body);

      print("FRANCHISE RESPONSE → $data");

      if (data["status"] == 200) {

        var responseData = data["data"];


        currentPage.value = responseData["current_page"] ?? 1;
        lastPage.value = responseData["last_page"] ?? 1;

        List newData = responseData["data"] ?? [];


        if (isLoadMore) {
          distributorList.addAll(newData);
        } else {
          distributorList.assignAll(newData);
        }

      } else if (data["status"] == 404) {

        if (!isLoadMore) {
          distributorList.clear();
        }

        EasyLoading.showError(data["message"]); // "No franchises found"

      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      print("ERROR → $e");
      EasyLoading.showError("Something went wrong");
    } finally {
      isLoading(false);
      isPaginationLoading(false);
    }
  }

  /// ---------------- LOAD MORE ----------------
  void loadMore() {

    if (currentPage.value < lastPage.value &&
        !isPaginationLoading.value) {

      currentPage.value++;

      getDistributor(
        search: searchText.value,
        category: selectedCategory.value,
        isLoadMore: true,
      );
    }
  }

  /// ---------------- REFRESH ----------------
  Future<void> refreshData() async {
    currentPage.value = 1;

    await getDistributor(
      search: "",
      category: "",
      isLoadMore: false,
    );
  }
}