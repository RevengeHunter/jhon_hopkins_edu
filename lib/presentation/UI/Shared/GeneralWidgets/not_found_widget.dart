import 'package:flutter/material.dart';

import '../Constants/font.dart';
import '../Constants/space_between.dart';

class NotFoundWidget extends StatefulWidget {
  String message;
  double alto;
  double ancho;

  NotFoundWidget({
    required this.message,
    required this.alto,
    required this.ancho,
  });

  @override
  State<NotFoundWidget> createState() => _NotFoundWidgetState();
}

class _NotFoundWidgetState extends State<NotFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: widget.ancho * 0.8,
              height: widget.alto * 0.4,
              child: const Image(
                image: AssetImage(
                  'assets/images/no-result.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            divider12,
            Text(
              widget.message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: paragraphTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
