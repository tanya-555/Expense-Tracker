import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartRep extends StatelessWidget {
  final Map<String, double> chart;

  PieChartRep(
    this.chart,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        dataMap: chart,
      ),
    );
  }
}
