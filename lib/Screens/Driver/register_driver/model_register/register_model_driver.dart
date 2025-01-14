class DriverRegisterModel {
  DriverRegisterModel({
    required this.token,
  });

  final String? token;

  factory DriverRegisterModel.fromJson(Map<String, dynamic> json) {
    return DriverRegisterModel(
      token: json["token"],
    );
  }
}