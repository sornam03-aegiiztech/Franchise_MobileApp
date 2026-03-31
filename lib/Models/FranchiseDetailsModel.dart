class FranchiseDetailsModel {
  final String businessId;
  final String businessName;
  final String category;
  final String description;
  final String investment;
  final String franchiseFee;
  final String capital;
  final String image;
  final String ownerImage;
  final String ownerName;
  final String mobile;
  final String email;
  final String profileView;
  final String contactStatus;


  FranchiseDetailsModel({
    required this.businessId,
    required this.businessName,
    required this.category,
    required this.description,
    required this.investment,
    required this.franchiseFee,
    required this.capital,
    required this.image,
    required this.ownerImage,
    required this.ownerName,
    required this.mobile,
    required this.email,
    required this.profileView,
    required this.contactStatus,

  });

  factory FranchiseDetailsModel.fromJson(Map<String, dynamic> json) {
    return FranchiseDetailsModel(
      businessId: json['business_id']?.toString() ?? "",
      businessName: json['business_name']?.toString() ?? "",
      category: json['business_category']?.toString() ?? "",
      description: json['business_description']?.toString() ?? "",
      investment: json['total_invesment']?.toString() ?? "",
      franchiseFee: json['franchise_fee']?.toString() ?? "",
      capital: json['liquid_capital_requried']?.toString() ?? "",
      image: json['image']?.toString() ?? "",
      ownerImage: json['brand_owner_image']?.toString() ?? "",
      ownerName: json['owner_company_name']?.toString() ?? "",
      mobile: json['business_mobile']?.toString() ?? "",
      email: json['business_email']?.toString() ?? "",
      profileView: json['profile_view']?.toString() ?? "",
      contactStatus: json['contact_status']?.toString() ?? "",

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
    );
  }
}
