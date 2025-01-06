class UserModel {
  String? firstname;
  String? lastname;
  String? phone;
  String? image;
  int? id;
  UserModel(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.image});
  UserModel.fromJson({required Map<String, dynamic> data}) {
    firstname = data['first-name'];
    lastname = data['last-name'];
    phone = data['phone'];
    image = data['profile_image'];
    id = data['id'];
  }

  //To Map
}
