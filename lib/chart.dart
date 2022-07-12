import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPageView extends StatefulWidget {
  const ChartPageView({super.key});

  @override
  State<ChartPageView> createState() => _ChartPageViewState();
}

class _ChartPageViewState extends State<ChartPageView> {
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return 'Jan';
            case 3:
              return 'Mar';
            case 5:
              return 'May';
            case 7:
              return 'Jul';
            case 9:
              return 'Sep';
            case 11:
              return 'Nov';
          }
          return 'x';
        },
      );

//todo create flSpot from data
  // final spots = _data
  //     .asMap()
  //     .entries
  //     .map((element) => FlSpot(
  //           element.key.toDouble(),
  //           element.value.value,
  //         ))
  //     .toList();

  @override
  Widget build(BuildContext context) {
// monthly data
    const List<FlSpot> monthlySpots = [
      FlSpot(1, 30.0),
      FlSpot(2, 31.0),
      FlSpot(3, 30.0),
      FlSpot(4, 27.0),
      FlSpot(5, 28.0),
      FlSpot(6, 30.0),
      FlSpot(7, 30.0),
      FlSpot(8, 30.0),
      FlSpot(9, 30.0),
      FlSpot(10, 30.0),
      FlSpot(11, 30.0),
    ];
    bool isPositiveChange = true;
    return LineChart(
      swapAnimationCurve: Curves.easeInOutCubic,
      swapAnimationDuration: Duration(milliseconds: 1000),
      LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: monthlySpots
                  .map((point) => FlSpot(point.x, point.y))
                  .toList(),
              isCurved: true,
              colors: [isPositiveChange ? Colors.green : Colors.red],
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          borderData: FlBorderData(
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: _bottomTitles,
            leftTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          )),
    );
  }
}
