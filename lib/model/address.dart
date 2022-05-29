class Address {
  Address({
    this.city,
    this.country,
    this.streetName,
    this.poBox,
  });

  final String? city;
  final String? country;
  final String? streetName;
  final String? poBox;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    country: json["country"],
    streetName: json["streetName"],
    poBox: json["poBox"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "streetName": streetName,
    "poBox": poBox,
  };
}
