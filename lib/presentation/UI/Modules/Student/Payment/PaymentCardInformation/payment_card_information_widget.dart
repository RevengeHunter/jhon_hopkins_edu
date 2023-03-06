import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/payment_model.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/month.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';

import '../../../../Shared/Constants/font.dart';

class PaymentCardInformationWidget extends StatelessWidget {
  PaymentModel paymentModel;

  PaymentCardInformationWidget({
    required this.paymentModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: ListTile(
        minVerticalPadding: 2.5,
        horizontalTitleGap: 1.0,
        leading: Icon(
          paymentModel.debt == 0 ? Icons.check_circle : Icons.attach_money,
          color: paymentModel.debt == 0 ? Colors.green : kBrandPrimaryColor,
          size: 30.0,
        ),
        title: Text(
          paymentModel.paymentConceptName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: paragraphCardBoldTextStyle,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chip(
              label: Text(
                paymentModel.debt != 0 && paymentModel.picture.isEmpty
                    ? "por pagar"
                    : paymentModel.debt != 0 && paymentModel.picture.isNotEmpty
                        ? "por validar"
                        : "pagado",
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor:
                  paymentModel.debt != 0 && paymentModel.picture.isEmpty
                      ? Colors.redAccent
                      : paymentModel.debt != 0 && paymentModel.picture.isNotEmpty
                          ? Colors.orangeAccent
                          : Colors.green,
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              paymentModel.monthId != 0
                  ? "${months[paymentModel.monthId]}"
                  : "",
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
            divider6,
            Text(
              "Deuda: ${paymentModel.debt}",
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
