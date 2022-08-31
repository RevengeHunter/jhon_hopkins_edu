import 'package:flutter/material.dart';

import '../Constants/space_between.dart';

class BackgroundLogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: height * 0.50,
          width: width * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/blue-logo.png',
                color: Colors.white.withOpacity(0.15),
                colorBlendMode: BlendMode.modulate,
              ),
              divider20,
            ],
          ),
        ),
      ),
    );
  }
}
