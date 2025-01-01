class RegisterModel {
  RegisterModel({
    required this.token,
    required this.user,
  });

  final String? token;
  final User? user;

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json["msg"]["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.phone,
    required this.firstname,
    required this.lastname,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json["first-name"],
      lastname: json["last-name"],
      phone: json["phone"],
      updatedAt: json["updated_at"] ?? "",
      createdAt: json["created_at"] ?? "",
      id: json["id"],
    );
  }
}
