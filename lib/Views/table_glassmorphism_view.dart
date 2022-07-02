import 'package:testingbloc/constants.dart';
import 'package:flutter/material.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:intl/intl.dart';

class TblForcastGlassmorphView extends StatelessWidget {
  const TblForcastGlassmorphView({
    Key? key,
    required this.futureApiData,
    required this.moonLanding,
  }) : super(key: key);

  final CurrentWeather futureApiData;
  final DateTime moonLanding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: GlassMorphism(
        start: 0.9,
        end: 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(100.0),
              2: FixedColumnWidth(100.0),
              3: FixedColumnWidth(100.0),
              // 4: FixedColumnWidth(100.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: List.generate(5, (int index) {
              var addingDate = moonLanding.add(Duration(days: index));
              var dayOfTheWeek = DateFormat('EEEE').format(addingDate);

              return TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dayOfTheWeek,
                        style: googleFontStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        addingDate.day.toString(),
                        style: googleFontStyle.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https:${futureApiData.forecast.forecastday[index].day.condition.icon}',
                        height: 50,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Row(
                      children: [
                        Text(
                          '${futureApiData.forecast.forecastday[index].day.maxtempC}\u00b0',
                          style: googleFontStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${futureApiData.forecast.forecastday[index].day.mintempC}\u00b0',
                          style: googleFontStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
