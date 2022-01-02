import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/chart_covid_case.dart';
import 'package:intl/intl.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/item_color_map.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  var formatter = NumberFormat('#,###,000');

  @override
  Widget build(BuildContext context) {
    final HomeController c1 = Get.find<HomeController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: GetX<HomeController>(
          initState: (_) {
            c1.getDataCovidCase();
            // c1.getDataCovidSevenDayCase();
            c1.getDataVaccineRate();
            c1.getDataCaseCovidProvince();
            Future.delayed(Duration(seconds: 2), () {
              c1.mapSource.value = MapShapeSource.asset('assets/vietnam3.json',
                  shapeDataField: 'name',
                  dataCount: c1.dataRateVaccineDistribution.length,
                  primaryValueMapper: (int index) =>
                      c1.dataRateVaccineDistribution[index].state,
                  shapeColorValueMapper: (int index) =>
                      c1.dataRateVaccineDistribution[index].color);
              c1.mapSource1.value = MapShapeSource.asset('assets/vietnam2.json',
                  shapeDataField: 'name',
                  dataCount: c1.dataRateCaseCovid.length,
                  primaryValueMapper: (int index) =>
                      c1.dataRateCaseCovid[index].state,
                  shapeColorValueMapper: (int index) =>
                      c1.dataRateCaseCovid[index].color);
            });
            // print(c1.listCaseSevenDay);
          },
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.only(left: 100, right: 100, top: 20),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(1, 0))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.grey, width: 1))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * 0.2,
                                  child: AutoSizeText(
                                    'Tổng số người mắc',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.orange),
                                    minFontSize: 10,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                c1.totalCase.value != 0
                                    ? AutoSizeText(
                                        formatter.format(c1.totalCase.value),
                                        style: TextStyle(fontSize: 16),
                                        minFontSize: 10,
                                      )
                                    : SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              CustomeColor.colorAppBar,
                                        ))
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.grey, width: 1))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * 0.2,
                                  child: AutoSizeText(
                                    'Tổng số người mất',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
                                    minFontSize: 10,
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                c1.totalDeath.value != 0
                                    ? AutoSizeText(
                                        formatter.format(c1.totalDeath.value),
                                        style: TextStyle(fontSize: 16),
                                        minFontSize: 10,
                                      )
                                    : SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              CustomeColor.colorAppBar,
                                        )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width * 0.2,
                                  child: AutoSizeText(
                                    'Đã bình phục',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                    minFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                c1.totalRecovered.value != 0
                                    ? AutoSizeText(
                                        formatter
                                            .format(c1.totalRecovered.value),
                                        style: TextStyle(fontSize: 16),
                                        minFontSize: 10,
                                      )
                                    : SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              CustomeColor.colorAppBar,
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ChartCovidCase(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: (size.width - 200 - 10) / 2,
                          height: size.height - 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(1, 0))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tỉ lệ tiêm Vaccine trên cả nước",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          ItemColorMap(
                                            text: ">80%",
                                            color: CustomeColor.rateVaccine3,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ItemColorMap(
                                            text: ">50%",
                                            color: CustomeColor.rateVaccine2,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ItemColorMap(
                                            text: "<50%",
                                            color: CustomeColor.rateVaccine1,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SfMaps(
                                          layers: [
                                            MapShapeLayer(
                                              source: _.mapSource.value,
                                              // showDataLabels: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          width: (size.width - 200 - 10) / 2 - 10,
                          height: size.height - 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(1, 0))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phân bố số ca nhiễm trên cả nước",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ItemColorMap(
                                            text: ">100,000",
                                            color: CustomeColor.rateCovid1,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ItemColorMap(
                                            text: ">10.000",
                                            color: CustomeColor.rateCovid2,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ItemColorMap(
                                            text: ">1000",
                                            color: CustomeColor.rateCovid3,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ItemColorMap(
                                            text: "<1000",
                                            color: CustomeColor.rateCovid4,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SfMaps(
                                          layers: [
                                            MapShapeLayer(
                                              // showDataLabels: true,
                                              source: _.mapSource1.value,
                                              // showDataLabels: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BottomSceen(size: size),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
