class PersonModel {
  PersonModel({
    required this.id,
    required this.paternalSurname,
    required this.maternalSurname,
    required this.firstName,
    required this.documentType,
    required this.documentNumber,
    required this.gender,
    required this.birthDay,
    required this.address,
    required this.personalEmail,
    required this.occupation,
  });

  int id;
  String paternalSurname;
  String maternalSurname;
  String firstName;
  int documentType;
  String documentNumber;
  int gender;
  DateTime birthDay;
  String address;
  String personalEmail;
  String occupation;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    id: json["id"],
    paternalSurname: json["paternalSurname"],
    maternalSurname: json["maternalSurname"],
    firstName: json["firstName"],
    documentType: json["documentType"],
    documentNumber: json["documentNumber"],
    gender: json["gender"],
    birthDay: DateTime.parse(json["birthDay"]),
    address: json["address"],
    personalEmail: json["personalEmail"],
    occupation: json["occupation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paternalSurname": paternalSurname,
    "maternalSurname": maternalSurname,
    "firstName": firstName,
    "documentType": documentType,
    "documentNumber": documentNumber,
    "gender": gender,
    "birthDay": birthDay.toIso8601String(),
    "address": address,
    "personalEmail": personalEmail,
    "occupation": occupation,
  };
}