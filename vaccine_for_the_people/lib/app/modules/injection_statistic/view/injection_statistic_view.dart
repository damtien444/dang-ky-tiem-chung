import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vaccine_for_the_people/app/core/components/loading_view.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/sale_data.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';

class InjectionStatisticView extends GetView<InjectionStatisticController> {
  InjectionStatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return GetX<InjectionStatisticController>(
            builder: (_){
              return controller.listProvinces.isNotEmpty ?
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                  child:
                    Stack(
                      children:[
                        Positioned.fill(
                            child: controller.isLoading.value ?
                            Container(
                                color: Colors.black45,
                                child: Center(
                                  child:  Padding(
                                    padding: EdgeInsets.only(top: (size.height-80)/3,bottom: (size.height-80)/2),
                                    child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: LoadingWidget()
                                    ),
                                  ),
                                ),
                            ): const SizedBox.shrink(),
                        ),
                        Positioned(
                          child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20),
                              color: controller.isLoading.value ? Colors.black.withOpacity(0.05): kHeaderPage,
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
                                            controller.isLoading.value=true;
                                              _.listDataChartByAge.clear();
                                              _.listDataChartByGender.clear();
                                              _.listDataChartByPriority.clear();
                                              _.listDataChartByArea.clear();
                                              _.listDataChartByNextShotType.clear();
                                              _.listDataChartByAreaNextShotTime.clear();
                                            controller.findListDistricts(data);
                                              _.getDataSearchChartProvince(data);
                                              _.fillDataChartProvince();
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
                                          listOptions: controller.listDistricts,
                                          onPress: (data){
                                            controller.findListWards(data);
                                            controller.isLoading.value=true;
                                            _.listDataChartByAge.value=[];
                                            _.listDataChartByGender.value=[];
                                            _.listDataChartByPriority.value=[];
                                            _.listDataChartByArea.value=[];
                                            _.listDataChartByNextShotType.value=[];
                                            _.listDataChartByAreaNextShotTime.value=[];
                                            _.getDataSearchChartProvinceAndDistrict(_.initialTinh.value, data);
                                            _.fillDataChartProvinceAndDistrict();
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
                                        listOptions: controller.listWards,
                                        value: controller.initialXa.value,
                                        onPress: (data){
                                          controller.initialXa.value = data;
                                          controller.isLoading.value=true;
                                          _.listDataChartByAge.value=[];
                                          _.listDataChartByGender.value=[];
                                          _.listDataChartByPriority.value=[];
                                          _.listDataChartByArea.value=[];
                                          _.listDataChartByNextShotType.value=[];
                                          _.listDataChartByAreaNextShotTime.value=[];
                                          _.getDataSearchChartFull(_.initialTinh.value, _.initialHuyen.value, data);
                                          _.fillDataChartAll();
                                        },
                                        mode: FormBuilderMode.DROP_DOWN),
                                  ),
                                  const SizedBox(
                                    width: 500,
                                  ),
                                ],
                              ),
                            ),
                            controller.listDataChartByArea.isNotEmpty ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80,left: 80,top: 20,bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          _.initialXa.value=="Tất cả" ? controller.listDataChartByArea.isNotEmpty ?
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
                                                  title: ChartTitle(text: 'Thống kê theo địa điểm'),
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
                                          ):const SizedBox.shrink():const SizedBox.shrink(),
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
                                              width: (MediaQuery.of(context).size.width/3)-80,
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
                                                        dataLabelSettings: const DataLabelSettings(
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
                                const SizedBox(height: 20,),
                                controller.listDataChartByArea.isNotEmpty?
                                const Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 40),
                                  child:  Text("Lưu ý:", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.red)),
                                ):
                                const SizedBox.shrink(),
                                controller.listDataChartByArea.isNotEmpty?
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                                  child: SizedBox(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.typeObject.length,
                                        itemBuilder: (context,index){
                                          return Text("  -  "+controller.typeObject[index],style: TextStyle(fontSize: 15,color: Colors.red,));
                                        }
                                    ),
                                  ),
                                ):const SizedBox.shrink(),
                                const BottomSceen()
                              ],
                            ):Center(
                              child: Padding(
                                padding:  EdgeInsets.only(top: (size.height-80)/2,bottom: (size.height-80)/2),
                              ),
                            )
                          ],
                        ),
                      ),
                        const Positioned(
                          bottom: 0,
                          child:  BottomSceen(),
                        )
                    ]),
              ):const SizedBox.shrink();
            },
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
