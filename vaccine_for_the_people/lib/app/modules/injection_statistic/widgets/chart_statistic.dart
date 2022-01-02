import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vaccine_for_the_people/app/data/models/sale_data.dart';

class ChartStatistic extends StatelessWidget {
  const ChartStatistic({
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
            title: ChartTitle(text: 'Thống kê'),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              ColumnSeries<SalesData,String>(
                  // dataSource: là hàm nếu nhận từ hàm,
                  dataSource: <SalesData>[
                    SalesData('10-12', 11002),
                    SalesData('11-12', 13042),
                    SalesData('12-12', 11002),
                    SalesData('13-12', 11002),
                    SalesData('14-12', 13042),
                    SalesData('15-12', 11002),
                    SalesData('16-12', 11002),
                    SalesData('17-12', 13042),
                    SalesData('18-12', 11002),
                    SalesData('19-12', 11002),
                    SalesData('20-12', 13042),
                    SalesData('21-12', 11002),

                  ],
                  xValueMapper: (SalesData sales, _) => sales.year.toString(),
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  name: "Số ca nhiễm",
                  legendIconType: LegendIconType.diamond,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  )
              )
            ]
        )
    );
  }
}

