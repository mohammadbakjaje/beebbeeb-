class RegisterModel {
  RegisterModel({
    required this.token,
  });

  final String? token;

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json["token"],
    );
  }
}
