class PaymentModel {
  PaymentModel({
    required this.paymentId,
    required this.paymentConceptName,
    required this.paymentCharge,
    required this.downPayment,
    required this.fixedDiscount,
    required this.percentageDiscount,
    required this.debt,
    required this.observation,
    required this.paymentType,
    required this.monthId,
    required this.picture,
  });

  int paymentId;
  String paymentConceptName;
  double paymentCharge;
  double downPayment;
  double fixedDiscount;
  double percentageDiscount;
  double debt;
  String observation;
  int paymentType;
  int monthId;
  String picture;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    paymentId: json["paymentId"],
    paymentConceptName: json["paymentConceptName"],
    paymentCharge: json["paymentCharge"].toDouble(),
    downPayment: json["downPayment"].toDouble(),
    fixedDiscount: json["fixedDiscount"].toDouble(),
    percentageDiscount: json["percentageDiscount"].toDouble(),
    debt: json["debt"].toDouble(),
    observation: json["observation"],
    paymentType: json["paymentType"],
    monthId: json["monthId"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "paymentId": paymentId,
    "paymentConceptName": paymentConceptName,
    "paymentCharge": paymentCharge,
    "downPayment": downPayment,
    "fixedDiscount": fixedDiscount,
    "percentageDiscount": percentageDiscount,
    "debt": debt,
    "observation": observation,
    "paymentType": paymentType,
    "monthId": monthId,
    "picture": picture,
  };
}
