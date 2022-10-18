import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/payment_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Payment/payment_service.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/academic_year_list_global.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/space_between.dart';

import '../../../../../dominio/Models/academic_year_model.dart';
import '../../../Shared/GeneralWidgets/loading_widget.dart';
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

  int statusValue = 0;
  bool _isLoading = false;
  bool debts = true;

  academicYearSelected(AcademicYearModel e) {
    if(statusValue != e.academicYearId){
      _isLoading = true;
      setState(() {});
      statusValue = e.academicYearId;
      _paymentService.getPayment(e.academicYearId, _prefs.idPerson).then((value) {
        if (value != null) {
          _listPayment = value;
          _isLoading = false;
          dataDistribution();
          setState(() {});
          return;
        }
        _isLoading = false;
        setState(() {});
        return;
      });
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 3.5,
        child: const Icon(
          Icons.refresh,
          size: 38.8,
        ),
        backgroundColor: kBrandPrimaryColor,
        onPressed: () {
          if (_academicYearModel != null) {
            academicYearSelected(_academicYearModel!);
            setState(() {});
          }
        },
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider12,
                    const Text(
                      "Mis deudas",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    divider3,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Periodo académico:",
                        ),
                        dividerWidth20,
                        Wrap(
                          children: _academicYearListGlobal.getAcademicYearList
                              .map(
                                (e) => FilterChip(
                                  selected: statusValue == e.academicYearId,
                                  selectedColor: statusColor["Selected"],
                                  label: Text(e.academicYearName),
                                  labelStyle: TextStyle(
                                    color: statusValue == e.academicYearId
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: statusValue == e.academicYearId
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                  checkmarkColor: Colors.white,
                                  onSelected: (bool isSelected) {
                                    academicYearSelected(e);
                                    _academicYearModel = AcademicYearModel(
                                      academicYearId: e.academicYearId,
                                      academicYearName: e.academicYearName,
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    divider20,
                    !_isLoading
                        ? Container(
                            child: Column(
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
                                                primary: debts
                                                    ? kBrandPrimaryColor
                                                    : kBrandSecondaryColor,
                                              ),
                                              child: const Text(
                                                "Deudas",
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
                                                primary: !debts
                                                    ? kBrandPrimaryColor
                                                    : kBrandSecondaryColor,
                                              ),
                                              child: const Text(
                                                "Pagos",
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PaymentCardInformationWidget(
                                      paymentModel: _listPaymentAux[index],
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
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
