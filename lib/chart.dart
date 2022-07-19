import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/constants.dart';

class ChartPageView extends StatefulWidget {
  const ChartPageView({super.key, required this.forecastData});
  final List<Forecastday> forecastData;

  @override
  State<ChartPageView> createState() => _ChartPageViewState();
}

class _ChartPageViewState extends State<ChartPageView> {
  List<Hour> get hourlList {
    var todayList =
        widget.forecastData[0].hour.sublist(DateTime.now().hour, 24);
    var tomorowList = widget.forecastData[1].hour;
    todayList.addAll(tomorowList);
    return todayList;
  }

  TextStyle get style => TextStyle(
        color: kPrimaryColor,
        // color: Color(0xFF5156ED),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    // margin: 10,

    getTitles() {
      var yy = DateTime.parse(hourlList[value.toInt()].time).hour;
      String textToDispaly = "";
      textToDispaly = "$yy:00";
      if (value.toInt() == spots.first.x.toInt() ||
          value.toInt() == spots.last.x.toInt()) {
        textToDispaly = " ";
      }
      return textToDispaly;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Text(getTitles(), style: style),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 4,
        getTitlesWidget: bottomTitleWidgets,
      );

  List<FlSpot> get spots => hourlList
      .asMap()
      .entries
      .map((e) => FlSpot(
            e.key.toDouble(),
            e.value.tempC!,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
// monthly data
    List<FlSpot> monthlySpots = spots;

    return LineChart(
      swapAnimationCurve: Curves.easeInOutCubic,
      swapAnimationDuration: const Duration(milliseconds: 1000),
      LineChartData(
          lineTouchData: LineTouchData(
              touchTooltipData:
                  LineTouchTooltipData(tooltipBgColor: Colors.white30)),
          maxY: 65,
          minX: 0,
          minY: 5,
          baselineY: 20,
          lineBarsData: [
            LineChartBarData(
              isStrokeCapRound: true,
              spots: monthlySpots
                  .map((point) => FlSpot(point.x, point.y))
                  .toList(),
              isCurved: true,
              color: Color(0xFF5156ED),
              dotData: FlDotData(
                show: false,
              ),
              barWidth: 4,
            ),
          ],
          borderData: FlBorderData(
              border:
                  const Border(bottom: BorderSide.none, left: BorderSide.none)),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: _bottomTitles,
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          )),
    );
  }
}
