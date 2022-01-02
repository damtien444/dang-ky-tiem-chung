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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20,horizontal: 100),
              child: ChartStatistic(),
            ),
          ],
        )
      ),
    );
  }
}
