class ScoreModel {
  ScoreModel({
    required this.blockId,
    this.bLockParentId,
    required this.blockName,
    required this.percent,
    this.blockChildren,
    this.indicators,
  });

  int blockId;
  int? bLockParentId;
  String blockName;
  double percent;
  List<ScoreModel>? blockChildren;
  List<Indicator>? indicators;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    blockId: json["BlockId"],
    bLockParentId: json["BLockParentId"] == null ? null : json["BLockParentId"],
    blockName: json["BlockName"],
    percent: json["Percent"].toDouble(),
    blockChildren: json["BlockChildren"] == null ? null : List<ScoreModel>.from(json["BlockChildren"].map((x) => ScoreModel.fromJson(x))),
    indicators: json["Indicators"] == null ? null : List<Indicator>.from(json["Indicators"].map((x) => Indicator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "BlockId": blockId,
    "BLockParentId": bLockParentId == null ? null : bLockParentId,
    "BlockName": blockName,
    "Percent": percent,
    "BlockChildren": blockChildren == null ? null : List<dynamic>.from(blockChildren?.map((x) => x.toJson()) ?? []),
    "Indicators": indicators == null ? null : List<dynamic>.from(indicators?.map((x) => x.toJson()) ?? []),
  };
}

class Indicator {
  Indicator({
    required this.indicatorId,
    required this.indicatorName,
  });

  int indicatorId;
  String indicatorName;

  factory Indicator.fromJson(Map<String, dynamic> json) => Indicator(
    indicatorId: json["IndicatorId"],
    indicatorName: json["IndicatorName"],
  );

  Map<String, dynamic> toJson() => {
    "IndicatorId": indicatorId,
    "IndicatorName": indicatorName,
  };
}
