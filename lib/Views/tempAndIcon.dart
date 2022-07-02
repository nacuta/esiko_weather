import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Widgets/iconDelegate.dart';

class TempAndIcon extends StatelessWidget {
  const TempAndIcon(
      {super.key, required this.currentTem, required this.codeTextSituation});
  final int currentTem;
  final String codeTextSituation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Center(
                child: Text(
                  '$currentTem\u00b0',
                  style: GoogleFonts.oswald(
                      height: 1,
                      fontWeight: FontWeight.w400,
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 150),
                ),
              ),
              Positioned(
                right: 85,
                bottom: -30,
                child: IconDelegate(
                  codetext: codeTextSituation,
                ),
              ),
              // Image.network(
              //   'https:${futureApiData.forecast.forecastday[0].day.condition.icon}',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}