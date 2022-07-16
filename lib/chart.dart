import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:intl/intl.dart';

class ChartPageView extends StatefulWidget {
  const ChartPageView({super.key, required this.forecastData});
  final List<Hour> forecastData;

  @override
  State<ChartPageView> createState() => _ChartPageViewState();
}

class _ChartPageViewState extends State<ChartPageView> {
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 42,
        margin: 15,
        interval: 3,
        getTextStyles: (context, value) => const TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: (value) {
          var yy = DateTime.parse(widget.forecastData[value.toInt()].time).hour;
          return "$yy:00";
        },
      );

  get spots => widget.forecastData
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

    bool isPositiveChange = true;
    return LineChart(
      swapAnimationCurve: Curves.easeInOutCubic,
      swapAnimationDuration: const Duration(milliseconds: 1000),
      LineChartData(
          lineTouchData: LineTouchData(
              touchTooltipData:
                  LineTouchTooltipData(tooltipBgColor: Colors.white30)),
          maxY: 50,
          minX: 0,
          minY: 5,
          baselineY: 20,
          lineBarsData: [
            LineChartBarData(
              spots: monthlySpots
                  .map((point) => FlSpot(point.x, point.y))
                  .toList(),
              isCurved: true,
              colors: [
                isPositiveChange ? Colors.deepPurple.shade400 : Colors.red
              ],
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
            bottomTitles: _bottomTitles,
            leftTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          )),
    );
  }
}
