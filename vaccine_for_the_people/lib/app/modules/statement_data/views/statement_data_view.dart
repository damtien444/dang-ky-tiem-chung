import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/theme/colors.dart';
import 'package:vaccine_for_the_people/app/core/theme/text_theme.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/components/form_builder_options.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';

import '../controllers/statement_data_controller.dart';

class StatementDataView extends GetView<StatementDataController> {
  StatementDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    'Tạo đợt tiêm chủng',
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
                        const TextSpan(text: '  /  Tạo đợt tiêm chủng'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FormBuilderOptions(
                          title: 'Tuổi',
                          require: false,
                          listOptions: controller.listAges,
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
                          title: 'Loại mũi tiêm',
                          require: false,
                          listOptions: controller.typeVaccine,
                          mode: FormBuilderMode.DROP_DOWN),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FormBuilderOptions(
                          title: 'Tỉnh/Thành phố',
                          require: false,
                          listOptions: Get.find<RegisterInjectionController>()
                              .listProvinces
                              .value,
                          mode: FormBuilderMode.DROP_DOWN),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FormBuilderOptions(
                          title: 'Tiền sử bệnh',
                          require: false,
                          listOptions: controller.anamesis,
                          mode: FormBuilderMode.DROP_DOWN),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FormBuilderOptions(
                        title: 'Nhóm ưu tiên',
                        require: false,
                        listOptions: controller.typeObject,
                        mode: FormBuilderMode.DROP_DOWN),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const BottomSceen(),
          ],
        ),
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
