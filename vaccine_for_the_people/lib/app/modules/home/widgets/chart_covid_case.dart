import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vaccine_for_the_people/app/data/models/sale_data.dart';

class ChartCovidCase extends StatelessWidget {
  const ChartCovidCase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(1,0)
              )
            ]
        ),
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Số ca nhiễm 15 ngày gần nhất'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                dataSource:  <SalesData>[
                  SalesData('10-12', 11002),
                  SalesData('11-12', 13042),
                  SalesData('12-12', 11002),
                  SalesData('13-12', 15002),
                  SalesData('14-12', 14502),
                  SalesData('15-12', 16000),
                  SalesData('16-12', 15332),
                  SalesData('17-12', 11321),
                  SalesData('18-12', 12352),
                  SalesData('19-12', 15643),
                  SalesData('20-12', 13022),
                  SalesData('21-12', 13921),
                  SalesData('22-12', 11081),
                  SalesData('23-12', 10273),
                  SalesData('24-12', 12425),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                // Enable data label
                // dataLabelSettings: DataLabelSettings(isVisible: true)
              )
            ]
        )
    );
  }
}

