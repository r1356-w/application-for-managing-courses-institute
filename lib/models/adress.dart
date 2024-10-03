class Address {
  Address({this.city, this.street, this.suite});
  String? street;
  String? suite;
  String? city;

  factory Address.fromJson(Map<String, dynamic> data) {
    return Address(
        street: data["street"], city: data["city"], suite: data["suite"]);
  }
}
