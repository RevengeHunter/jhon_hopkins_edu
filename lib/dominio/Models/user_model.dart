class UserModel {
  UserModel({
    required this.userName,
    required this.roles,
    required this.isVerified,
    required this.jwtTokenExpireDate,
    required this.jwtToken,
    required this.personId,
    required this.documentNumber,
  });

  String userName;
  List<String> roles;
  bool isVerified;
  DateTime jwtTokenExpireDate;
  String jwtToken;
  int personId;
  String documentNumber;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["userName"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    isVerified: json["isVerified"],
    jwtTokenExpireDate: DateTime.parse(json["jwtTokenExpireDate"]),
    jwtToken: json["jwtToken"],
    personId: json["personId"],
    documentNumber: json["documentNumber"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "isVerified": isVerified,
    "jwtTokenExpireDate": jwtTokenExpireDate.toIso8601String(),
    "jwtToken": jwtToken,
    "personId": personId,
    "documentNumber": documentNumber,
  };
}