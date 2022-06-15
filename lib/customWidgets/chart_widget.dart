import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GraphWidget({Key? key}) : super(key: key);

  @override
  GraphWidgetState createState() => GraphWidgetState();
}

class GraphWidgetState extends State<GraphWidget> {
  List<_SalesData> data = [
    _SalesData('10',10),
    _SalesData('20', 20),
    _SalesData('30', 30),
    _SalesData('40', 20),
    _SalesData('50', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCartesianChart(
            borderColor: Colors.grey,
            primaryXAxis: CategoryAxis(),
            // Chart title
            // Enable legend
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
