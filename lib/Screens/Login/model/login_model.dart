class LoginModel {
  LoginModel({
    required this.status,
    required this.token,
  });

  final bool? status;
  final String? token;

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) {
    return LoginModel(
      status: json["status"],
      token: json["msg"]["token"],
    );
  }
}
