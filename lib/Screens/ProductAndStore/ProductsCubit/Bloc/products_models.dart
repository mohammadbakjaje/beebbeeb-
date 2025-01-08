class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String price;
  final String image;
  final String categoryName;
  final String storeName;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categoryName,
    required this.storeName,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      categoryName: json['categoryName'],
      storeName: json['storeName'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
