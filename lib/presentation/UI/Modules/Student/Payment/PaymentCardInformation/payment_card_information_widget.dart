import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/payment_model.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/month.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';

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
          paymentModel.debt == 0 ? Icons.check_circle : Icons.dangerous,
          color: paymentModel.debt == 0 ? Colors.green : Colors.redAccent,
          size: 30.0,
        ),
        title: Text(
          paymentModel.paymentConceptName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kBrandPrimaryColor,
          ),
        ),
        subtitle: Text(
          paymentModel.debt != 0 &&  paymentModel.picture.isEmpty ? "Estado: pago pendiente"
          : paymentModel.debt != 0 &&  paymentModel.picture.isNotEmpty ? "Estado: pendiente validar pago"
          : "Estado: pago cancelado",
          style: const TextStyle(
            fontSize: 12.0,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              paymentModel.monthId != 0 ? "${months[paymentModel.monthId]}" : "",
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
