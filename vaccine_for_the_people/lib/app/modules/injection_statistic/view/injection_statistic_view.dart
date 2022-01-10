import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/widgets/chart_statistic.dart';
import 'package:vaccine_for_the_people/app/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/widgets/form_builder_options.dart';

class InjectionStatisticView extends GetView<InjectionStatisticController> {
  InjectionStatisticView({Key? key}) : super(key: key);
  final InjectionStatisticController c = Get.put(InjectionStatisticController(
      vietNamRepository: VietNamRepository(vnProvider: VnProvider())));

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
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                              value: c.initialTinh.value,
                              onPress: (data) =>
                                  c.findListDistricts(data),
                              listOptions: c.listProvinces,
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
                              value: c.initialHuyen.value,
                              listOptions: c.listDistricts,
                              onPress: (data) => c.findListWards(data),
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
                            listOptions: c.listWards,
                            value: c.initialXa.value,
                            onPress: (data) => {c.initialXa.value = data},
                            mode: FormBuilderMode.DROP_DOWN),
                      ),
                      const SizedBox(
                        width: 300,
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
                              print(c.initialTinh);
                              print(c.initialHuyen);
                              print(c.initialXa);
                            },
                            child: const Center(
                              child: Text("Thống kê"),
                            )
                        ),
                      )
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