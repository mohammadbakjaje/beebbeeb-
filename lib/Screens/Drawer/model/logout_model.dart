class LogoutModel {
  LogoutModel({
    required this.msg,
    required this.status,
  });

  final bool? status;
  final String? msg;

  factory LogoutModel.fromJson(Map<dynamic, dynamic> json) {
    return LogoutModel(
      status: json["status"],
      msg: json["msg"],
    );
  }
}
