import 'package:flutter/material.dart';
import 'dart:math';
import '../../../Shared/Constants/presentation_messages.dart';
import '../../../Shared/Constants/space_between.dart';

class IntroductionPage extends StatelessWidget {

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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: height * 0.50,
              width: width * 0.8,
              padding: const EdgeInsets.symmetric(
                  vertical: 30.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
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
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  divider20,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
