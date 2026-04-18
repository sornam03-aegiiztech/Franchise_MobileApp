class FranchiseDetailsModel {
  final String businessId;
  final String brandname;
  final String category;
  final String description;
  final String investment;
  final String franchiseFee;
  final String capital;
  final List<String> images;
  final String ownerImage;
  final String ownerName;
  final String mobile;
  final String email;
  final String profileView;
  final String contactStatus;
  final String units;
  final String regions;
  final String term;
  final String keyBenefits;


  FranchiseDetailsModel({
    required this.businessId,
    required this.brandname,
    required this.category,
    required this.description,
    required this.investment,
    required this.franchiseFee,
    required this.capital,
    required this.images,
    required this.ownerImage,
    required this.ownerName,
    required this.mobile,
    required this.email,
    required this.profileView,
    required this.contactStatus,
    required this.units,
    required this.regions,
    required this.term,
    required this.keyBenefits,


  });

  factory FranchiseDetailsModel.fromJson(Map<String, dynamic> json) {
    return FranchiseDetailsModel(
      businessId: json['business_id']?.toString() ?? "",
      brandname: json['brand_name']?.toString() ?? "",
      category: json['business_category']?.toString() ?? "",
      description: json['business_description']?.toString() ?? "",
      investment: json['total_invesment']?.toString() ?? "",
      franchiseFee: json['franchise_fee']?.toString() ?? "",
      capital: json['liquid_capital_requried']?.toString() ?? "",
      images: (json['images'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      ownerImage: json['brand_owner_image']?.toString() ?? "",
      ownerName: json['owner_company_name']?.toString() ?? "",
      mobile: json['mobile_number']?.toString() ?? "",
      email: json['business_email']?.toString() ?? "",
      profileView: json['profile_view']?.toString() ?? "",
      contactStatus: json['contact_status']?.toString() ?? "",
      units: json['units']?.toString() ?? "",
      regions: json['regions']?.toString() ?? "",
      term: json['term']?.toString() ?? "",
      keyBenefits: json['key_benefits_added']?.toString() ?? "",

    );
  }
}

class DistributorDetailsModel {
  final String businessId;
  final String brandName;
  final String category;
  final String description;
  final String territory;
  final String units;
  final String days;
  final String logo;
  final String ownerImage;
  final String ownerName;
  final String mobile;
  final String email;
  final String address;
  final String city;
  final String profileView;
  final String contactStatus;
  final String products;

  DistributorDetailsModel({
    required this.businessId,
    required this.brandName,
    required this.category,
    required this.description,
    required this.territory,
    required this.units,
    required this.days,
    required this.logo,
    required this.ownerImage,
    required this.ownerName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.profileView,
    required this.contactStatus,
    required this.products
  });

  factory DistributorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DistributorDetailsModel(
      businessId: json['business_id']?.toString() ?? "",
      brandName: json['brand_name']?.toString() ?? "",
      category: json['business_category']?.toString() ?? "",
      description: json['business_description']?.toString() ?? "",
      territory: json['branch_territory']?.toString() ?? "",
      units: json['branch_territory_units']?.toString() ?? "",
      days: json['branch_territory_day']?.toString() ?? "",
      logo: json['brand_logo']?.toString() ?? "",
      ownerImage: json['owner_image']?.toString() ?? "",
      ownerName: json['company_name']?.toString() ?? "",
      mobile: json['mobile']?.toString() ?? "",
      email: json['email']?.toString() ?? "",
      address: json['address']?.toString() ?? "",
      city: json['city']?.toString() ?? "",
      profileView: json['profile_view']?.toString() ?? "",
      contactStatus: json['contact_status']?.toString() ?? "",
      products: json['product_handled']?.toString() ?? "",
    );
  }
}
