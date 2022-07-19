import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:testingbloc/Widgets/icon_delegate.dart';
import 'package:testingbloc/utils.dart';

class TempAndIcon extends StatelessWidget {
  const TempAndIcon(
      {super.key, required this.currentTem, required this.codeTextSituation});
  final int currentTem;
  final String codeTextSituation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        // fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                '$currentTem\u00b0',
                //keeping thei here because copyWith it does not update the fontWeight
                style: GoogleFonts.oswald(
                    height: 1,
                    fontWeight: FontWeight.w400,
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 140),
              ),
            ),
          ),
          Positioned(
            right: 100,
            bottom: 5,
            child: IconDelegate(
              codetext: codeTextSituation,
            ),
          ),
        ],
      ),
    );
  }
}
