class BimesterModel {
  BimesterModel({
    required this.bimesterId,
    required this.name,
    required this.startClassAt,
    required this.endClassAt,
    required this.scoreRegisterStartAt,
    required this.scoreRegisterEndAt,
    required this.bimesterStatusId,
  });

  int bimesterId;
  String name;
  DateTime startClassAt;
  DateTime endClassAt;
  DateTime scoreRegisterStartAt;
  DateTime scoreRegisterEndAt;
  int bimesterStatusId;

  factory BimesterModel.fromJson(Map<String, dynamic> json) => BimesterModel(
    bimesterId: json["bimesterId"],
    name: json["name"],
    startClassAt: DateTime.parse(json["startClassAt"]),
    endClassAt: DateTime.parse(json["endClassAt"]),
    scoreRegisterStartAt: DateTime.parse(json["scoreRegisterStartAt"]),
    scoreRegisterEndAt: DateTime.parse(json["scoreRegisterEndAt"]),
    bimesterStatusId: json["bimesterStatusId"],
  );

  Map<String, dynamic> toJson() => {
    "bimesterId": bimesterId,
    "name": name,
    "startClassAt": startClassAt.toIso8601String(),
    "endClassAt": endClassAt.toIso8601String(),
    "scoreRegisterStartAt": scoreRegisterStartAt.toIso8601String(),
    "scoreRegisterEndAt": scoreRegisterEndAt.toIso8601String(),
    "bimesterStatusId": bimesterStatusId,
  };
}