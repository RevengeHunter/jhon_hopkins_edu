import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'dart:math';
import '../../../Shared/Constants/font.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.06,
                  ),
                  divider12,
                  Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              _shared.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: -65,
                        bottom: -20,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: kLogin02.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: -75,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: kLogin01.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 35.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bienvenid@: ",
                          maxLines: 1,
                          style: subTitleBoldTextStyleHigh,
                        ),
                        Text(
                          _shared.fullName.toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: paragraphBoldTextStyleHigh,
                        ),
                        divider12,
                        Text(
                          message,
                          style: paragraphTextStyle,
                        ),
                        divider6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kLogin02.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Grado",
                                    style: cardIntroductionTitleTextStyle,
                                  ),
                                  divider6,
                                  Text(
                                    _shared.gradeName.toUpperCase(),
                                    style: cardIntroductionContentTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kLogin02.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Sección",
                                    style: cardIntroductionTitleTextStyle,
                                  ),
                                  divider6,
                                  Text(
                                    _shared.sectionName.toUpperCase(),
                                    style: cardIntroductionContentTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 100,
                              decoration: BoxDecoration(
                                color: kLogin02.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Salón",
                                    style: cardIntroductionTitleTextStyle,
                                  ),
                                  divider6,
                                  Text(
                                    _shared.roomName.toUpperCase(),
                                    style: cardIntroductionContentTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  divider20,
                  SizedBox(
                    width: width,
                    height: height * 0.15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
