import 'package:ehr/Model/lab_screen_response_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphWidget extends StatefulWidget {
  List<TestResults> graphList;
  GraphWidget( {required this.graphList});

  @override
  GraphWidgetState createState() => GraphWidgetState();
}

class GraphWidgetState extends State<GraphWidget> {


  List<_SalesData> data = [
    // _SalesData('10',120,),
    // _SalesData('20', 121),
    // _SalesData('30', 122),
    // _SalesData('40', 123),
    // _SalesData('50', 120),
    // _SalesData('60', 119),
    // _SalesData('70', 126),
    // _SalesData('80', 126),
    // _SalesData('90', 123),
  ];
  List<_SalesData> dataSortedList = [];
  List<_SalesData> reverseList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<widget.graphList[0].values!.length;i++){
      var dt = DateTime.fromMillisecondsSinceEpoch(widget.graphList[0].values![i].testDate!);
      var d24 = DateFormat('yyyy-MM-dd').format(dt);
      data.add(_SalesData('${d24}', double.parse(widget.graphList[0].values![i].testResultValue.toString())));
    }
    data.sort((a, b) => a.year.compareTo(b.year));
    for(int i=0;i<data.length;i++){
      var dt = data[i].year;
      var d24 = DateFormat('dd/MM/yyyy').format(DateTime.parse(dt));
      reverseList.add(_SalesData('${d24}', double.parse(widget.graphList[0].values![i].testResultValue.toString())));
      dataSortedList=reverseList.reversed.toList();
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
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
