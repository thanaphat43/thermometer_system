import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../connect/ip.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Charts Demo',
//       home: AgeCharts(Api: 'http://192.168.1.10:3000/getdegrees_roomit'),
//     ),
//   );
// }

// MAIN WIDGET

class AgeCharts extends StatefulWidget {
  final String Api;

  const AgeCharts({this.Api});

  @override
  _AgeChartsState createState() => _AgeChartsState();
}

class _AgeChartsState extends State<AgeCharts> {
  var chart;

  Future<List<Ages>> getChartData(widget) async {
    final response =
        await http.get(Uri.parse("${IP().connect}/temp_chart/${widget.Api}"));
    final List<dynamic> jsonData = jsonDecode(response.body);
    print(jsonData);

    return jsonData.map((data) => Ages.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Japanese Age Working Populations'),
        // ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder<List>(
            future: getChartData(widget),
            builder: (context, dataapi) {
              if (dataapi.hasError) print(dataapi.error);
              return dataapi.hasData
                  ? ShowChart(data: dataapi.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class ShowChart extends StatelessWidget {
  final List<Ages> data;

  ShowChart({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 400,
        height: 300,
        child: Column(
          children: [
            //Initialize the chart widget

            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true),
                series: <ChartSeries<Ages, String>>[
                  LineSeries<Ages, String>(
                    dataSource: data,
                    xValueMapper: (Ages sales, _) => sales.tempDatetime,
                    yValueMapper: (Ages sales, _) => sales.tempTemperature,
                    name: 'อุณหภูมิ (ํ  ํC )',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  LineSeries<Ages, String>(
                    dataSource: data,
                    xValueMapper: (Ages sales, _) => sales.tempDatetime,
                    yValueMapper: (Ages sales, _) => sales.tempHumidity,
                    name: 'ความชื้น (%)',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales, this.sales2);

  final String year;
  final double sales;
  final double sales2;
}

// CHART

// class ShowChart extends StatelessWidget {
//   final List<Ages> data;

//   ShowChart({this.data});

//   static List<charts.Series<Ages, num>> _createSampleData(dataAPI) {
//     return [
//       new charts.Series<Ages, num>(
//         id: 'idDegrees',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         areaColorFn: (_, __) =>
//             charts.MaterialPalette.blue.shadeDefault.lighter,
//         domainFn: (Ages ages, _) => ages.tempId,
//         measureFn: (Ages ages, _) => ages.tempTemperature,
//         // measureFn: (Ages ages, _) => (ages.datetime).to(),
//         // measureFn: (Ages ages, _) => ages.datetime,

//         data: dataAPI,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: charts.LineChart(
//         _createSampleData(data),
//         defaultRenderer:
//             new charts.LineRendererConfig(includeArea: true, stacked: true),
//         animate: true,
//         domainAxis: charts.NumericAxisSpec(
//           tickProviderSpec:
//               charts.BasicNumericTickProviderSpec(zeroBound: false),
//         ),
//       ),
//     );
//   }
// }

// double tempTemperature;
// int tempHumidity;

class Ages {
  int tempId;
  int deviceId;
  int sensorId;
  var tempTemperature;
  var tempHumidity;
  String tempDatetime;
  String tempIp;
  String tempIpServer;

  Ages(
      {this.tempId,
      this.deviceId,
      this.sensorId,
      this.tempTemperature,
      this.tempHumidity,
      this.tempDatetime,
      this.tempIp,
      this.tempIpServer});

  Ages.fromJson(Map<String, dynamic> json) {
    tempId = json['temp_id'];
    deviceId = json['device_id'];
    sensorId = json['sensor_id'];
    tempTemperature = json['temp_temperature'];
    tempHumidity = json['temp_humidity'];
    tempDatetime = json['temp_datetime'];
    tempIp = json['temp_ip'];
    tempIpServer = json['temp_ip_server'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_id'] = this.tempId;
    data['device_id'] = this.deviceId;
    data['sensor_id'] = this.sensorId;
    data['temp_temperature'] = this.tempTemperature;
    data['temp_humidity'] = this.tempHumidity;
    data['temp_datetime'] = this.tempDatetime;
    data['temp_ip'] = this.tempIp;
    data['temp_ip_server'] = this.tempIpServer;
    return data;
  }
}
