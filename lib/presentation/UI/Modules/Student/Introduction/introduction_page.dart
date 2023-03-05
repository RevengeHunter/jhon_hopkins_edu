import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'dart:math';
import '../../../Shared/Constants/presentation_messages.dart';
import '../../../Shared/Constants/space_between.dart';

class IntroductionPage extends StatefulWidget {
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final SPGlobal _shared = SPGlobal();
  String message = '';
  Random rnd = new Random();

  getRandomMessage() {
    const min = 0;
    int max = presentation_messages.length;
    for (var i = 0; i < max; i++) {
      message = presentation_messages[min + rnd.nextInt(max - min)] ?? "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomMessage();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: height * 0.50,
            width: width * 0.8,
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/blue-logo.png',
                ),
                const Text(
                  "Bienvenido: ",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w200,
                    color: kBrandPrimaryColor,
                  ),
                ),
                Text(
                  _shared.fullName.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: kBrandPrimaryColor,
                  ),
                ),
                divider12,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                divider20,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
