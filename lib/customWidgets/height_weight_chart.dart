import 'package:ehr/Model/lab_screen_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../Model/height_weight_model.dart';

class HeightWeightChart extends StatefulWidget {
  List<HeighWeightResponse> graphList;
  HeightWeightChart( {required this.graphList});

  @override
  HeightWeightChartState createState() => HeightWeightChartState();
}

class HeightWeightChartState extends State<HeightWeightChart> {


  List<_SalesData> data = [];
  List<_SalesData> dataa = [];
  List<_SalesData> dataSortedList = [];
  List<_SalesData> dataSortedListt = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<widget.graphList.length;i++){
      var dt = DateTime.fromMillisecondsSinceEpoch(widget.graphList[i].changedDate!);
      var d24 = DateFormat('yyyy-MM-dd').format(dt);
      data.add(_SalesData('${d24}', double.parse(widget.graphList[i].height.toString())));
    }
    data.sort((a, b) => a.year.compareTo(b.year));
    for(int i=0;i<data.length;i++){
      var dt = data[i].year;
      var d24 = DateFormat('dd/MM/yyyy').format(DateTime.parse(dt));
      dataSortedList.add(_SalesData('${d24}', double.parse(widget.graphList[i].height.toString())));
    }

    for(int i=0;i<widget.graphList.length;i++){
      var dt = DateTime.fromMillisecondsSinceEpoch(widget.graphList[i].changedDate!);
      var d24 = DateFormat('yyyy-MM-dd').format(dt);
      dataa.add(_SalesData('${d24}', double.parse(widget.graphList[i].weight.toString())));
    }
    dataa.sort((a, b) => a.year.compareTo(b.year));
    for(int i=0;i<dataa.length;i++){
      var dt = dataa[i].year;
      var d24 = DateFormat('dd/MM/yyyy').format(DateTime.parse(dt));
      dataSortedListt.add(_SalesData('${d24}', double.parse(widget.graphList[i].weight.toString())));
    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(

              majorGridLines: MajorGridLines(
                    width: 1,
                    color: Colors.transparent,
                ),
                minorGridLines: MinorGridLines(
                    width: 1,
                    color: Colors.transparent,
                ),
            ),
            primaryYAxis:  CategoryAxis(
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Colors.transparent,
                ),
                minorGridLines: MinorGridLines(
                  width: 1,
                  color: Colors.transparent,
                ),
            ),
            borderColor: Colors.transparent,

            // Chart title
            // Enable legend
            legend: Legend(isVisible: false),

            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: false),
            series: <ChartSeries<_SalesData, String>>[

              LineSeries<_SalesData, String>(

                color: Color(0xFFB459CB),
                  dataSource: dataSortedList.reversed.toList(),
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
              LineSeries<_SalesData, String>(

                  color: Color(0xFF7BCB59),
                  dataSource: dataSortedListt.reversed.toList(),
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
