import 'dart:async';
import 'dart:convert';
import 'package:franchaise_app/View/Customer%20Module/AuthModule/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Appconfig.dart';
import '../../Models/FranchiseDetailsModel.dart';



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

        var franchiseListData = data["data"]["franchises"] ?? [];
        var distributorListData = data["data"]["distributors"] ?? [];



        franchises.assignAll(franchiseListData);
        distributors.assignAll(distributorListData);

        /// 🔥 STORE FIRST FRANCHISE DATA
        if (franchiseListData.isNotEmpty) {

          await AppConfig.pref.setString(
            "franchise_business_id",
            franchiseListData[0]["business_id"] ?? "",
          );

          await AppConfig.pref.setString(
            "franchise_business_category",
            franchiseListData[0]["business_category"] ?? "",
          );
        }

        /// 🔥 STORE FIRST DISTRIBUTOR DATA
        if (distributorListData.isNotEmpty) {

          await AppConfig.pref.setString(
            "distributor_business_id",
            distributorListData[0]["business_id"] ?? "",
          );

          await AppConfig.pref.setString(
            "distributor_business_category",
            distributorListData[0]["business_category"] ?? "",
          );
        }




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

  // Future<void> getServices() async {
  //   try {
  //     isLoading(true);
  //
  //     final response = await http.get(
  //       Uri.parse("${AppConfig.baseURL}services_list"),
  //     );
  //
  //     final data = jsonDecode(response.body);
  //
  //
  //
  //
  //     if (data["status"] == 200) {
  //       List list = data["data"];
  //
  //       tabs.clear();
  //       tabs.add("All");
  //
  //       for (var item in list) {
  //         tabs.add(item["service_name"]);
  //       }
  //     }
  //
  //   } catch (e) {
  //     EasyLoading.showError("Error");
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> getServices() async {
    try {
      isLoading(true);

      final token = AppConfig.pref.getString("token") ?? "";

      print("SERVICE TOKEN → $token");

      final response = await http.get(
        Uri.parse("${AppConfig.baseURL}services_list"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token", // 🔥 IMPORTANT
        },
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
        searchText.value = search;
        selectedCategory.value = category;

      }



      String? token = AppConfig.pref.getString("token");

      if (token == null || token.isEmpty) {
        EasyLoading.showError("Session expired. Login again");
        return;
      }

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
      print("TOKEN → $token");

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


    searchText.value = "";
    selectedCategory.value = "";

    currentPage.value = 1;
    franchiseList.clear();

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
        searchText.value = search;
        selectedCategory.value = category;
      }



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

      print("Distributor RESPONSE → $data");

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


    searchText.value = "";
    selectedCategory.value = "";

    currentPage.value = 1;
   distributorList.clear();

    await getDistributor(
      search: "",
      category: "",
      isLoadMore: false,
    );
  }
}


class AllServicesController extends GetxController {

  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  var services = [].obs;

  var searchText = "".obs;
  var selectedCategory = "".obs;

  int currentPage = 1;
  int lastPage = 1;



  @override
  void onInit() {
    super.onInit();
    getServices();
  }

  Future<void> getServices({String search = "", String category = "", bool loadMore = false}) async {
    try {

      if(loadMore){
        if(currentPage > lastPage) return;
        isMoreLoading(true);
      }else{
        currentPage = 1;
        services.clear();
        isLoading(true);
      }

      String? token = AppConfig.pref.getString("token");

      final response = await http.get(
        Uri.parse(
          "${AppConfig.baseURL}all_service?page=$currentPage&search=$search&category=$category",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      );

      final data = jsonDecode(response.body);

      if (data["status"] == 200) {

        if(!loadMore){
          EasyLoading.showSuccess(data["message"]);
        }

        var list = data["data"]["data"] ?? [];

        final uniqueList = {
          for (var item in list) item['business_id']: item
        }.values.toList();

        services.value = uniqueList;

        currentPage = data["data"]["current_page"];
        lastPage = data["data"]["last_page"];

        currentPage++; // 🔥 next page

      } else {
        EasyLoading.showError(data["message"]);
      }

    } catch (e) {
      EasyLoading.showError("Error");
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }
  Future<void> refreshData() async {

    searchText.value = "";
    selectedCategory.value = "";

    await getServices(
      search: "",
      category: "",
    );
  }
}

class FavouriteController extends GetxController {
  var favouriteIds = <String>[].obs;
  var isLoading = false.obs;


  Future<void> addFavourite({
    required String businessId,
    required String category,
    required String role,

  }) async {
    try {
      isLoading.value = true;

      /// 🔑 TOKEN
      String? token = AppConfig.pref.getString("token");
      print("🔑 TOKEN → $token");

      /// 📦 PARAMS
      Map<String, String> params = {
        "business_id": businessId,
        "business_category": category,
        "business_role": role,

      };
      print("📦 PARAMS → $params");

      /// 📡 HEADERS
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      };
      print("📡 HEADERS → $headers");

      var response = await http.post(
        Uri.parse("${AppConfig.baseURL}add_favourite"),
        headers: headers,
        body: params,
      );

      print("🌐 STATUS CODE → ${response.statusCode}");
      print("🌐 RAW RESPONSE → ${response.body}");

      var data = jsonDecode(response.body);

      print("✅ PARSED RESPONSE → $data");

      int status = data["status"];

      if (status == 200) {
        if (!favouriteIds.contains(businessId)) {
          favouriteIds.add(businessId);
        }
        EasyLoading.showSuccess(data["message"]);
      } else if (status == 401) {
        EasyLoading.showError("Unauthorized - Login again");
      } else if (status == 409) {
        if (!favouriteIds.contains(businessId)) {
          favouriteIds.add(businessId);
        }
        EasyLoading.showInfo(data["message"]);
      } else {
        EasyLoading.showError("Something went wrong");
      }

    } catch (e) {
      print("❌ FAV ERROR → $e");
      EasyLoading.showError("Server error");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> removeFavourite({
    required String businessId,
    required String category,
    required String role,
  }) async {
    try {
      isLoading.value = true;


      String? token = AppConfig.pref.getString("token");
      print("🔑 TOKEN → $token");


      Map<String, String> params = {
        "business_id": businessId,
        "business_category": category,
        "business_role": role,
      };
      print("📦 PARAMS → $params");


      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      };
      print("📡 HEADERS → $headers");


      var request = http.Request(
        "DELETE",
        Uri.parse("${AppConfig.baseURL}remove_favourite"),
      );

      request.headers.addAll(headers);
      request.bodyFields = params;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("🌐 STATUS CODE → ${response.statusCode}");
      print("🌐 RAW RESPONSE → $responseBody");

      var data = jsonDecode(responseBody);

      int status = data["status"];


      if (status == 200) {
        favouriteIds.remove(businessId);

        EasyLoading.showSuccess(data["message"]);
      }


      else if (status == 401) {
        EasyLoading.showError(data["message"]);
      }


      else if (status == 404) {
        favouriteIds.remove(businessId); // already removed case
        EasyLoading.showInfo(data["message"]);
      }


      else {
        EasyLoading.showError("Something went wrong");
      }

    } catch (e) {
      print("❌ REMOVE FAV ERROR → $e");
      EasyLoading.showError("Server error");
    } finally {
      isLoading.value = false;
    }
  }
}



class GetFavouriteController extends GetxController {

  /// 🔥 LIST DATA
  var favouriteList = <dynamic>[].obs;

  /// 🔥 LOADING STATES
  var isLoading = false.obs;
  var isPaginationLoading = false.obs;

  /// 🔥 PAGINATION
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  /// 🔥 SEARCH & FILTER
  var searchText = "".obs;
  var selectedCategory = "".obs;

  /// 🔥 DEBOUNCE
  Timer? _debounce;



  /// 🔥 TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  /// 🔥 MAIN API CALL
  Future<void> getFavourites({bool isLoadMore = false}) async {
    try {

      /// 🔥 Loading control
      if (isLoadMore) {
        isPaginationLoading.value = true;
      } else {
        isLoading.value = true;
        currentPage.value = 1;
        favouriteList.clear();
      }

      /// 🔥 TOKEN
      final token = await getToken();

      /// 🔥 QUERY PARAMS
      final url = Uri.parse("${AppConfig.baseURL}get_favourites")
          .replace(queryParameters: {
        "page": currentPage.value.toString(),
        if (searchText.value.isNotEmpty) "search": searchText.value,
        if (selectedCategory.value.isNotEmpty)
          "category": selectedCategory.value,
      });

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final data = jsonDecode(response.body);

      /// 🔴 401 → Unauthorized
      if (data['status'] == 401) {
        EasyLoading.showError("Session Expired. Please login again");
        Get.to(CustomerLoginscreen());
        return;
      }

      /// 🟡 404 → No Data
      else if (data['status'] == 404) {

        if (!isLoadMore) {
          favouriteList.clear();
        }

        if (!isLoadMore) {
          EasyLoading.showInfo(data['message'] ?? "No favourites found");
        }
      }

      /// 🟢 200 → Success
      else if (data['status'] == 200) {

        lastPage.value = data['last_page'] ?? 1;

        List list = data['data'] ?? [];

        if (isLoadMore) {
          favouriteList.addAll(list);
        } else {
          favouriteList.value = list;
        }
      }

      /// ❌ Unknown error
      else {
        EasyLoading.showError(data['message'] ?? "Something went wrong");
      }

    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      isLoading.value = false;
      isPaginationLoading.value = false;
    }
  }

  /// 🔥 LOAD MORE
  void loadMore() {
    if (currentPage.value < lastPage.value &&
        !isPaginationLoading.value) {
      currentPage.value++;
      getFavourites(isLoadMore: true);
    }
  }

  /// 🔥 SEARCH (with debounce)
  void onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchText.value = value;
      currentPage.value = 1;
      getFavourites();
    });
  }

  /// 🔥 CATEGORY FILTER
  void onCategoryChange(String category) {
    selectedCategory.value = category;
    currentPage.value = 1;
    getFavourites();
  }

  /// 🔥 CLEAR SEARCH
  void clearSearch() {
    searchText.value = "";
    currentPage.value = 1;
    getFavourites();
  }

  /// 🔥 REFRESH
  Future<void> refreshData() async {
    currentPage.value = 1;
    await getFavourites();
  }

  /// 🔥 INIT
  @override
  void onInit() {
    super.onInit();
    getFavourites();
  }

  /// 🔥 CLEANUP
  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}



class FranchiseDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<FranchiseDetailsModel?> details =
  Rx<FranchiseDetailsModel?>(null);

  RxString errorMessage = "".obs;


  Future<void> fetchFranchiseDetails({
    required String type,        // Franchise / Distributor
    required String businessId,  // dynamic id
    required String viewType,    // profile / contact
  }) async {
    try {
      isLoading(true);
      errorMessage("");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      /// ✅ Query Params (Correct Way)
      final uri = Uri.parse(
          "${AppConfig.baseURL}customer_business_details")
          .replace(queryParameters: {
        "type": type,
        "business_id": businessId,
        "view_type": viewType,
      });

      print("API URL => $uri");

      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      print("STATUS CODE => ${response.statusCode}");
      print("RESPONSE BODY => ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null) {
          details.value =
              FranchiseDetailsModel.fromJson(jsonData['data']);
        } else {
          errorMessage("No data found");
        }
      } else {
        errorMessage("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      errorMessage("Error: $e");
      print("ERROR => $e");
    } finally {
      isLoading(false);
    }
  }
}

class GetDistributorDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<DistributorDetailsModel?> details =
  Rx<DistributorDetailsModel?>(null);

  Future<void> fetchDistributorDetails({
    required String type,
    required String businessId,
    required String viewType,
  }) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final uri = Uri.parse(
          "${AppConfig.baseURL}customer_business_details")
          .replace(queryParameters: {
        "type": type,
        "business_id": businessId,
        "view_type": viewType,
      });
      print("API URL => $uri");

      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      print("STATUS CODE => ${response.statusCode}");
      print("RESPONSE BODY => ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        details.value =
            DistributorDetailsModel.fromJson(data['data']);
      }
    } catch (e) {
      print("ERROR => $e");
    } finally {
      isLoading(false);
    }
  }
}

class FranchiseContactController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<FranchiseDetailsModel?> details =
  Rx<FranchiseDetailsModel?>(null);

  Future<void> fetchContactDetails({
    required String type,
    required String businessId,
  }) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final uri = Uri.parse(
          "${AppConfig.baseURL}customer_business_details")
          .replace(queryParameters: {
        "type": type,
        "business_id": businessId,
        "view_type": "contact", // 🔥 important
      });

      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        details.value =
            FranchiseDetailsModel.fromJson(data['data']);
      }
    } catch (e) {
      print("ERROR => $e");
    } finally {
      isLoading(false);
    }
  }
}

class DistributorContactController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<DistributorDetailsModel?> details =
  Rx<DistributorDetailsModel?>(null);

  Future<void> fetchDistributorContact({
    required String type,
    required String businessId,
  }) async {
    try {
      isLoading(true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final uri = Uri.parse(
          "${AppConfig.baseURL}customer_business_details")
          .replace(queryParameters: {
        "type": type,
        "business_id": businessId,
        "view_type": "contact", // 🔥 important
      });

      final response = await http.get(uri, headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        details.value =
            DistributorDetailsModel.fromJson(data['data']);
      }
    } catch (e) {
      print("ERROR => $e");
    } finally {
      isLoading(false);
    }
  }
}
