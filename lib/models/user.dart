class User {
  User(
      {required this.email,
      required this.name,
      required this.id,
      required this.phone});
  int? id;
  String? name;
  String? email;
  String? phone;

  factory User.fromJson(
    Map<String, dynamic> data,
  ) {
    return User(
      id: data["id"],
      name: data["name"],
      email: data["email"],
      phone: data["phone"],
    );
  }
}
