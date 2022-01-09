import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/widgets/chart_statistic.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';

class InjectionStatisticView extends GetView<InjectionStatisticController> {
  InjectionStatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
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
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: '  /  Thống kê tiêm chủng'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FormBuilderOptions(
                          title: 'Tỉnh/Thành phố',
                          value: Get.find<RegisterInjectionController>()
                              .initialTinh
                              .value,
                          onPress: (data) =>
                              Get.find<RegisterInjectionController>()
                                  .findListDistricts(data),
                          listOptions: Get.find<RegisterInjectionController>()
                              .listProvinces
                              .value,
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
                          value: Get.find<RegisterInjectionController>()
                              .initialHuyen
                              .value,
                          listOptions: Get.find<RegisterInjectionController>()
                              .listDistricts
                              .value,
                          onPress: (data) =>
                              Get.find<RegisterInjectionController>()
                                  .findListWards(data),
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
                        listOptions: Get.find<RegisterInjectionController>()
                            .listWards
                            .value,
                        value: Get.find<RegisterInjectionController>()
                            .initialXa
                            .value,
                        onPress: (data) => {
                              Get.find<RegisterInjectionController>()
                                  .initialXa
                                  .value = data
                            },
                        mode: FormBuilderMode.DROP_DOWN),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            );
          }),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            child: ChartStatistic(),
          ),
        ],
      )),
    );
  }

  final labelStyle = Get.textTheme.headline6!.copyWith(
    fontWeight: kFontWeightBold,
  );
  final noteStyle = Get.textTheme.bodyText2!.copyWith(
    color: kError,
  );
}
