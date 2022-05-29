class UserInformation {
  UserInformation({
    this.firstName,
    this.lastName,
    this.email,
    this.telephoneNumber,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? telephoneNumber;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        telephoneNumber: json["telephoneNumber"],
      );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "telephoneNumber": telephoneNumber,
  };
}
