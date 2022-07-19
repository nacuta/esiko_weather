import 'package:flutter/material.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:testingbloc/constants.dart';

class Hydro extends StatelessWidget {
  const Hydro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassMorphism(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        start: 0.9,
        end: 0.6,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Insert icon with precipitation
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.umbrella_rounded,
                      color: kPrimaryColor,
                    ),
                    Text(
                      '30%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      'Precipitation',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              // Insert icon with humidity
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.pin_drop,
                      color: kPrimaryColor,
                    ),
                    Text(
                      '20%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      'Humidity',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              // Insert icon with wind
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.wind_power_outlined,
                      color: kPrimaryColor,
                    ),
                    Text(
                      '12km/h',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      'Wind Speed',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
