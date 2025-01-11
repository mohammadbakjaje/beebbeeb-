class StoreModel {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String logo;
  final String description;
  final String createdAt;
  final String updatedAt;
  final List<CategoryModel> categories;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.logo,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.categories,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    var categoriesJson = json['categories'] as List;
    List<CategoryModel> categoriesList = categoriesJson
        .map((category) => CategoryModel.fromJson(category))
        .toList();

    return StoreModel(
      id: json["store"]['id'],
      name: json["store"]['name'],
      address: json["store"]['address'],
      phone: json["store"]['phone'],
      logo: json["store"]['logo'],
      description: json["store"]['description'],
      createdAt: json["store"]['created_at'],
      updatedAt: json["store"]['updated_at'],
      categories: categoriesList,
    );
  }
}

class CategoryModel {
  final int id;
  final int storeId;
  final String name;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.storeId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      storeId: json['store_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
