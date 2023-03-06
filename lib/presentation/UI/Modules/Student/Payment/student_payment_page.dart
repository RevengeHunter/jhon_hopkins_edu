import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/payment_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Payment/payment_service.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/academic_year_list_global.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';

import '../../../../../dominio/Models/academic_year_model.dart';
import '../../../Shared/Constants/font.dart';
import '../../../Shared/GeneralWidgets/loading_widget.dart';
import '../../../Shared/GeneralWidgets/not_found_widget.dart';
import 'PaymentCardInformation/payment_card_information_widget.dart';

class StudentPaymentPage extends StatefulWidget {
  @override
  State<StudentPaymentPage> createState() => _StudentPaymentPageState();
}

class _StudentPaymentPageState extends State<StudentPaymentPage> {
  final PaymentService _paymentService = PaymentService();

  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();

  final SPGlobal _prefs = SPGlobal();
  List<PaymentModel> _listPayment = [];
  final List<PaymentModel> _listPaymentAux = [];

  AcademicYearModel? _academicYearModel;
  Widget responseWidget = Column();
  Widget responseReloadWidget = const SizedBox();

  int academicYearId = 0;
  bool _isLoading = false;
  bool debts = true;
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  academicYearSelected(AcademicYearModel e) {
    if (academicYearId != e.academicYearId) {
      academicYearId = e.academicYearId;
      loadInformation();
    }
  }

  dataDistribution() {
    _listPaymentAux.clear();
    _listPayment.forEach((element) {
      if (debts && element.debt > 0) {
        _listPaymentAux.add(element);
      } else if (!debts && element.debt == 0) {
        _listPaymentAux.add(element);
      }
    });

    responseWidget = Column(
      children: [
        _listPayment.isNotEmpty
            ? Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!debts) {
                          debts = true;
                          dataDistribution();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary:
                            debts ? kBrandPrimaryColor : kBrandSecondaryColor,
                      ),
                      child: const Text(
                        "Deudas",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  dividerWidth10,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (debts) {
                          debts = false;
                          dataDistribution();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary:
                            !debts ? kBrandPrimaryColor : kBrandSecondaryColor,
                      ),
                      child: const Text(
                        "Pagos",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        divider12,
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: _listPaymentAux.length,
          itemBuilder: (BuildContext context, int index) {
            return PaymentCardInformationWidget(
              paymentModel: _listPaymentAux[index],
            );
          },
        ),
      ],
    );

    responseReloadWidget = FloatingActionButton(
      elevation: 3.5,
      child: const Icon(
        Icons.refresh,
        size: 38.8,
      ),
      backgroundColor: kBrandPrimaryColor,
      onPressed: () {
        if (_academicYearModel != null) {
          loadInformation();
          setState(() {});
        }
      },
    );

    setState(() {});
  }

  loadInformation() {
    _isLoading = true;
    setState(() {});

    _paymentService.getPayment(academicYearId, _prefs.idPerson).then((value) {
      if (value != null) {
        _listPayment = value;
        _isLoading = false;
        dataDistribution();

        setState(() {});
        return;
      }

      responseWidget = NotFoundWidget(
        message:
            "No tiene pagos por realizar en el año académico seleccionado.",
        alto: height,
        ancho: width,
      );

      _isLoading = false;
      setState(() {});
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: responseReloadWidget,
      body: SafeArea(
        child: Stack(
          children: [
            //BackgroundLogoWidget(),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              //clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider12,
                    const Text(
                      "Mis deudas",
                      style: titleTextStyle,
                    ),
                    divider3,
                    const Text(
                      "Elige un periodo académico para realizar la consulta.",
                      style: subTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    divider12,
                    _academicYearListGlobal.getAcademicYearList.isNotEmpty
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: _academicYearListGlobal
                                    .getAcademicYearList
                                    .map(
                                      (e) => FilterChip(
                                        selected:
                                            academicYearId == e.academicYearId,
                                        selectedColor: statusColor["Selected"],
                                        padding: const EdgeInsets.all(2),
                                        label: Text(
                                          e.academicYearName,
                                          style: chipTextStyle,
                                        ),
                                        labelStyle: TextStyle(
                                          color:
                                              academicYearId == e.academicYearId
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight:
                                              academicYearId == e.academicYearId
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                        ),
                                        checkmarkColor: Colors.white,
                                        onSelected: (bool isSelected) {
                                          academicYearSelected(e);
                                          _academicYearModel =
                                              AcademicYearModel(
                                            academicYearId: e.academicYearId,
                                            academicYearName:
                                                e.academicYearName,
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          )
                        : NotFoundWidget(
                            message:
                                "No se encontro ningún año académico en el que este matriculado",
                            alto: height,
                            ancho: width,
                          ),
                    divider20,
                    !_isLoading
                        ? responseWidget
                        : SizedBox(
                            height: height * 0.7,
                            width: width,
                            child: const LoadingWidget(),
                          ),
                    divider20,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
