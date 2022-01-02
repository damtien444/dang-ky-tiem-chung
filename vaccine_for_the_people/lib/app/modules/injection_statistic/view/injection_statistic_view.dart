import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/widgets/chart_statistic.dart';

class InjectionStatisticView extends GetView<InjectionStatisticController> {
  const InjectionStatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children:[
            const SizedBox(height: 20,),
            Center(child: const Text("Thông tin thống kê tiêm chủng",style: TextStyle(fontSize: 19,fontFamily: "impact"),)),
            Padding(
              padding: EdgeInsets.symmetric(vertical:20,horizontal: 100),
              child: ChartStatistic(),
            ),
          ],
        )
      ),
    );
  }
}
