class UserModel {
  final String email;
  final String firstName;
  final String token;

  UserModel({
    required this.email,
    required this.firstName,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      firstName: json["first_name"] ?? "",
      token: json["token"],
    );
  }
}
