import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/sale_data.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';

class InjectionStatisticView extends GetView<InjectionStatisticController> {
  InjectionStatisticView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetX<InjectionStatisticController>(
            builder: (_){
              return controller.listProvinces.isNotEmpty ?
              ListView(
                children: [
                  Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 20),
                      color: kHeaderPage,
                      child: Row(
                        children: [
                          AutoSizeText(
                            'Thống kê tiêm chủng',
                            style: Get.textTheme.headline5,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          AutoSizeText.rich(
                            TextSpan(
                              style: Get.textTheme.bodyText2,
                              children: [
                                TextSpan(
                                  text: 'Trang chủ',
                                  style: noteStyle,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                const TextSpan(text: '  /  Thống kê tiêm chủng'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: FormBuilderOptions(
                                    title: 'Tỉnh/Thành phố',
                                    value: controller.initialTinh.value,
                                    onPress: (data){
                                      controller.findListDistricts(data);
                                      Future.delayed(const Duration(seconds: 2),(){
                                        _.listDataChartByAge.value=[];
                                        _.listDataChartByGender.value=[];
                                        _.listDataChartByPriority.value=[];
                                        _.listDataChartByArea.value=[];
                                        _.listDataChartByNextShotType.value=[];
                                        _.listDataChartByAreaNextShotTime.value=[];
                                        _.getDataSearchChartProvince(data);
                                        _.getDataSearchChartProvince(data);
                                        _.fillDataChartProvince();
                                      });

                                    },

                                    listOptions: controller.listProvinces,
                                    mode: FormBuilderMode.DROP_DOWN),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: FormBuilderOptions(
                                    title: 'Quận/Huyện',
                                    value: controller.initialHuyen.value,
                                    listOptions: controller.listDistricts.value,
                                    onPress: (data){
                                      controller.findListWards(data);
                                      _.listDataChartByAge.value=[];
                                      _.listDataChartByGender.value=[];
                                      _.listDataChartByPriority.value=[];
                                      _.listDataChartByArea.value=[];
                                      _.listDataChartByNextShotType.value=[];
                                      _.listDataChartByAreaNextShotTime.value=[];
                                      _.getDataSearchChartProvinceAndDistrict(_.initialTinh.value, data);
                                      print(_.listDataArea[1].sId);
                                      Future.delayed(const Duration(seconds: 3),(){
                                        _.fillDataChartProvinceAndDistrict();
                                      });
                                    },
                                    mode: FormBuilderMode.DROP_DOWN),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: FormBuilderOptions(
                                  title: 'Phường/Xã',
                                  listOptions: controller.listWards.value,
                                  value: controller.initialXa.value,
                                  onPress: (data) =>
                                  {controller.initialXa.value = data},
                                  mode: FormBuilderMode.DROP_DOWN),
                            ),
                            const SizedBox(
                              width: 400,
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                  style:ElevatedButton.styleFrom(
                                    primary: CustomeColor.colorAppBar, //background color of button
                                    shape: RoundedRectangleBorder( //to set border radius to button
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                  onPressed: () {
                                    _.listDataChartByAge.value=[];
                                    _.listDataChartByGender.value=[];
                                    _.listDataChartByPriority.value=[];
                                    _.listDataChartByArea.value=[];
                                    _.listDataChartByNextShotType.value=[];
                                    _.listDataChartByAreaNextShotTime.value=[];
                                    if(_.initialTinh.value!="Tất cả" && _.initialHuyen.value=="Tất cả" && _.initialXa.value=="Tất cả"){
                                      _.getDataSearchChartProvince(_.initialTinh.value);
                                      _.fillDataChartProvince();
                                    }
                                    if(_.initialTinh.value!="Tất cả" && _.initialHuyen.value!="Tất cả" && _.initialXa.value=="Tất cả"){
                                      _.getDataSearchChartProvinceAndDistrict(_.initialTinh.value, _.initialHuyen.value);
                                      _.fillDataChartProvinceAndDistrict();
                                    }
                                    if(_.initialTinh.value!="Tất cả" && _.initialHuyen.value!="Tất cả" && _.initialXa.value!="Tất cả"){
                                      _.getDataSearchChartFull(_.initialTinh.value, _.initialHuyen.value, _.initialXa.value);
                                      _.fillDataChartAll();
                                    }
                                  },
                                  child: const Center(
                                    child: Text("Thống kê"),
                                  )
                              ),
                            )
                          ],
                        ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80,left: 80,top: 20,bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              controller.listDataChartByArea.isNotEmpty ?
                              Container(
                                  width: (MediaQuery.of(context).size.width)-160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
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
                                      title: ChartTitle(text: 'Thống kê theo diện tích'),
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <ChartSeries>[
                                        ColumnSeries<SalesData,String>(
                                          // dataSource: là hàm nếu nhận từ hàm,
                                            dataSource: controller.listDataChartByArea,
                                            xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                            yValueMapper: (SalesData sales, _) => sales.sales,
                                            name: "Số mũi tiêm cần đáp ứng",
                                            legendIconType: LegendIconType.diamond,
                                            dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                            )
                                        )
                                      ]
                                  )
                              ):const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80,left: 80,top: 10,bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              controller.listDataChartByAreaNextShotTime.isNotEmpty ?
                              Container(
                                width: (MediaQuery.of(context).size.width)-160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
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
                                    title: ChartTitle(text: 'Thống kê theo thời gian'),
                                    tooltipBehavior: TooltipBehavior(enable: true),
                                    series: <ChartSeries>[
                                      ColumnSeries<SalesData,String>(
                                        // dataSource: là hàm nếu nhận từ hàm,
                                          dataSource: controller.listDataChartByAreaNextShotTime,
                                          xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                          name: "Số mũi tiêm theo thời gian",
                                          legendIconType: LegendIconType.diamond,
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                          )
                                      )
                                    ]
                                ),
                              ):const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40,left: 40,top: 10,bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 20,),
                              controller.listDataChartByNextShotType.isNotEmpty ?
                              Container(
                                  width: (MediaQuery.of(context).size.width/3)-20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const[
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: Offset(1,0)
                                        )
                                      ]
                                  ),
                                  child:  SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      title: ChartTitle(text: 'Thống kê theo loại vaccine'),
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <ChartSeries>[
                                        ColumnSeries<SalesData,String>(
                                          // dataSource: là hàm nếu nhận từ hàm,
                                            dataSource: controller.listDataChartByNextShotType,
                                            xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                            yValueMapper: (SalesData sales, _) => sales.sales,
                                            name: "Mũi tiêm thuộc loại vaccine",
                                            legendIconType: LegendIconType.diamond,
                                            dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                            )
                                        )
                                      ]
                                  )
                              ):const SizedBox.shrink(),
                              const SizedBox(width: 20,),
                              controller.listDataChartByAge.isNotEmpty ?
                              Container(
                                width: (MediaQuery.of(context).size.width/3)-20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
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
                                      title: ChartTitle(text: 'Thống kê theo độ tuổi'),
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <ChartSeries>[
                                        ColumnSeries<SalesData,String>(
                                          // dataSource: là hàm nếu nhận từ hàm,
                                            dataSource: controller.listDataChartByAge
                                            ,
                                            xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                            yValueMapper: (SalesData sales, _) => sales.sales,
                                            name: "Số trường hợp cần tiêm",
                                            legendIconType: LegendIconType.diamond,
                                            dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                            )
                                        )
                                      ]
                                  ),
                              ):const SizedBox.shrink(),
                              const SizedBox(width: 20,),
                              controller.listDataChartByGender.isNotEmpty ?
                              Container(
                                  width: (MediaQuery.of(context).size.width/3)-100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const[
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: Offset(1,0)
                                        )
                                      ]
                                  ),
                                  child:  SfCartesianChart(
                                      primaryXAxis: CategoryAxis(),
                                      title: ChartTitle(text: 'Thống kê theo giới tính'),
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <ChartSeries>[
                                        ColumnSeries<SalesData,String>(
                                          // dataSource: là hàm nếu nhận từ hàm,
                                            dataSource: controller.listDataChartByGender,
                                            xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                            yValueMapper: (SalesData sales, _) => sales.sales,
                                            name: "Số mũi tiêm",
                                            legendIconType: LegendIconType.diamond,
                                            dataLabelSettings: DataLabelSettings(
                                              isVisible: true,
                                            )
                                        )
                                      ]
                                  )
                              ):const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40,left: 40,top: 10,bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              controller.listDataChartByPriority.isNotEmpty ?
                              Container(
                                width: (MediaQuery.of(context).size.width)-80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black12,
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: Offset(1,0)
                                      )
                                    ]
                                ),
                                child:  SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    title: ChartTitle(text: 'Thống kê theo thứ tự ưu tiên'),
                                    tooltipBehavior: TooltipBehavior(enable: true),
                                    series: <ChartSeries>[
                                      ColumnSeries<SalesData,String>(
                                        // dataSource: là hàm nếu nhận từ hàm,
                                          dataSource: controller.listDataChartByPriority,
                                          xValueMapper: (SalesData sales, _) => sales.year.toString(),
                                          yValueMapper: (SalesData sales, _) => sales.sales,
                                          name: "Số mũi tiêm cần",
                                          legendIconType: LegendIconType.diamond,
                                          dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                          )
                                      )
                                    ]
                                ),
                              ):const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
              ):const SizedBox.shrink();
            },
          )
      ),
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
