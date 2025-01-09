class StoreModel {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String logo;
  final String description;
  final String createdAt;
  final String updatedAt;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.logo,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      logo: json['logo'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}